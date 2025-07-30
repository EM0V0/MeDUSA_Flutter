import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/constants/app_constants.dart';
import 'encryption_service.dart';
import 'security_service.dart';

/// 安全网络服务抽象类
abstract class SecureNetworkService {
  /// 发送加密的GET请求
  Future<Response<T>> secureGet<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requireEncryption = true,
  });

  /// 发送加密的POST请求
  Future<Response<T>> securePost<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requireEncryption = true,
  });

  /// 发送加密的PUT请求
  Future<Response<T>> securePut<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requireEncryption = true,
  });

  /// 发送加密的DELETE请求
  Future<Response<T>> secureDelete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requireEncryption = true,
  });

  /// 设置认证令牌
  void setAuthToken(String token);

  /// 清除认证令牌
  void clearAuthToken();

  /// 验证服务器证书
  Future<bool> verifyServerCertificate();

  /// 生成请求签名
  Future<String> generateRequestSignature(Map<String, dynamic> data, String timestamp);

  /// 检查请求频率限制
  Future<bool> checkRateLimit(String endpoint);
}

/// 安全网络服务实现
class SecureNetworkServiceImpl implements SecureNetworkService {
  final Dio _dio;
  final EncryptionService _encryptionService;
  final SecurityService _securityService;
  final FlutterSecureStorage _secureStorage;

  SecureNetworkServiceImpl({
    required Dio dio,
    required EncryptionService encryptionService,
    required SecurityService securityService,
    required FlutterSecureStorage secureStorage,
  })  : _dio = dio,
        _encryptionService = encryptionService,
        _securityService = securityService,
        _secureStorage = secureStorage {
    _setupSecureInterceptors();
  }

  void _setupSecureInterceptors() {
    // 请求拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            // 添加安全头部
            options.headers['Accept'] = 'application/json';
            options.headers['Content-Type'] = 'application/json';
            options.headers['User-Agent'] = 'MeDUSA/1.0.0';
            options.headers['X-Request-ID'] = await _generateRequestId();
            options.headers['X-Timestamp'] = DateTime.now().millisecondsSinceEpoch.toString();

            // 验证证书固定
            if (!await verifyServerCertificate()) {
              handler.reject(
                DioException(
                  requestOptions: options,
                  error: 'Certificate verification failed',
                  type: DioExceptionType.badCertificate,
                ),
              );
              return;
            }

            // 检查频率限制
            if (!await checkRateLimit(options.path)) {
              handler.reject(
                DioException(
                  requestOptions: options,
                  error: 'Rate limit exceeded',
                  type: DioExceptionType.connectionError,
                ),
              );
              return;
            }

            // 加密请求数据
            if (options.data != null && options.method != 'GET') {
              await _encryptRequestData(options);
            }

            handler.next(options);
          } catch (e) {
            handler.reject(
              DioException(
                requestOptions: options,
                error: 'Request preparation failed: $e',
                type: DioExceptionType.unknown,
              ),
            );
          }
        },
        onResponse: (response, handler) async {
          try {
            // 解密响应数据
            if (response.data != null) {
              await _decryptResponseData(response);
            }

            // 验证响应完整性
            if (!await _verifyResponseIntegrity(response)) {
              handler.reject(
                DioException(
                  requestOptions: response.requestOptions,
                  error: 'Response integrity check failed',
                  type: DioExceptionType.badResponse,
                ),
              );
              return;
            }

            handler.next(response);
          } catch (e) {
            handler.reject(
              DioException(
                requestOptions: response.requestOptions,
                error: 'Response processing failed: $e',
                type: DioExceptionType.unknown,
              ),
            );
          }
        },
        onError: (error, handler) {
          _handleSecureError(error);
          handler.next(error);
        },
      ),
    );
  }

  Future<String> _generateRequestId() async {
    final random = await _securityService.generateSecureRandom(16);
    return base64Encode(random);
  }

  Future<void> _encryptRequestData(RequestOptions options) async {
    try {
      if (options.data is Map<String, dynamic>) {
        final data = options.data as Map<String, dynamic>;
        final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

        // 添加时间戳和nonce
        data['timestamp'] = timestamp;
        data['nonce'] = await _generateRequestId();

        // 生成请求签名
        final signature = await generateRequestSignature(data, timestamp);
        data['signature'] = signature;

        // 加密数据
        final cryptoKey = await _getCryptoKey();
        final encryptedData = await _encryptionService.encryptJson(data, cryptoKey);

        options.data = encryptedData;
      }
    } catch (e) {
      throw Exception('Failed to encrypt request data: $e');
    }
  }

  Future<void> _decryptResponseData(Response response) async {
    try {
      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;

        // 检查是否包含加密字段
        if (data.containsKey('iv') && data.containsKey('ciphertext') && data.containsKey('tag')) {
          final cryptoKey = await _getCryptoKey();
          final decryptedData = await _encryptionService.decryptJson(
            Map<String, String>.from(data),
            cryptoKey,
          );
          response.data = decryptedData;
        }
      }
    } catch (e) {
      throw Exception('Failed to decrypt response data: $e');
    }
  }

  Future<bool> _verifyResponseIntegrity(Response response) async {
    try {
      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;

        // 验证响应签名
        if (data.containsKey('signature')) {
          final receivedSignature = data['signature'] as String;
          final timestamp = data['timestamp'] as String?;

          if (timestamp != null) {
            final calculatedSignature = await generateRequestSignature(data, timestamp);
            return receivedSignature == calculatedSignature;
          }
        }
      }
      return true; // 如果没有签名，默认通过
    } catch (e) {
      return false;
    }
  }

  void _handleSecureError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        _securityService.logSecurityEvent('Network timeout', metadata: {
          'error': error.message,
          'url': error.requestOptions.uri.toString(),
        });
        break;
      case DioExceptionType.badResponse:
        _securityService.logSecurityEvent('Bad response', metadata: {
          'status_code': error.response?.statusCode,
          'url': error.requestOptions.uri.toString(),
        });
        break;
      case DioExceptionType.badCertificate:
        _securityService.logSecurityEvent('Certificate error', metadata: {
          'error': error.message,
          'url': error.requestOptions.uri.toString(),
        });
        break;
      case DioExceptionType.connectionError:
        _securityService.logSecurityEvent('Connection error', metadata: {
          'error': error.message,
          'url': error.requestOptions.uri.toString(),
        });
        break;
      default:
        _securityService.logSecurityEvent('Unknown network error', metadata: {
          'error': error.message,
          'url': error.requestOptions.uri.toString(),
        });
    }
  }

  Future<String> _getCryptoKey() async {
    String? key = await _secureStorage.read(key: AppConstants.encryptionKeyKey);
    if (key == null) {
      throw Exception('Encryption key not found in secure storage');
    }
    return key;
  }

  @override
  Future<Response<T>> secureGet<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requireEncryption = true,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response<T>> securePost<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requireEncryption = true,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response<T>> securePut<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requireEncryption = true,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response<T>> secureDelete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requireEncryption = true,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  @override
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  @override
  Future<bool> verifyServerCertificate() async {
    try {
      final host = _dio.options.baseUrl.replaceAll('https://', '').replaceAll('http://', '');
      final port = _dio.options.baseUrl.startsWith('https') ? 443 : 80;

      return await _securityService.verifyCertificatePinning(host, port);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> generateRequestSignature(Map<String, dynamic> data, String timestamp) async {
    try {
      // 创建签名字符串
      final sortedKeys = data.keys.toList()..sort();
      final signatureString = sortedKeys.where((key) => key != 'signature').map((key) => '$key=${data[key]}').join('&');

      // 添加时间戳和密钥
      final key = await _getCryptoKey();
      final fullString = '$signatureString&timestamp=$timestamp&key=$key';

      // 生成SHA-256哈希
      final bytes = utf8.encode(fullString);
      final digest = sha256.convert(bytes);

      return digest.toString();
    } catch (e) {
      throw Exception('Failed to generate request signature: $e');
    }
  }

  @override
  Future<bool> checkRateLimit(String endpoint) async {
    try {
      final now = DateTime.now().millisecondsSinceEpoch;
      final key = 'rate_limit_$endpoint';

      final storedData = await _secureStorage.read(key: key);
      if (storedData != null) {
        final data = jsonDecode(storedData) as Map<String, dynamic>;
        final count = data['count'] as int;
        final lastReset = data['last_reset'] as int;

        // 重置间隔：1分钟
        const resetInterval = 60 * 1000;

        if (now - lastReset > resetInterval) {
          // 重置计数器
          await _secureStorage.write(
              key: key,
              value: jsonEncode({
                'count': 1,
                'last_reset': now,
              }));
          return true;
        } else if (count >= 100) {
          // 每分钟最多100个请求
          return false;
        } else {
          // 增加计数器
          await _secureStorage.write(
              key: key,
              value: jsonEncode({
                'count': count + 1,
                'last_reset': lastReset,
              }));
          return true;
        }
      } else {
        // 首次请求
        await _secureStorage.write(
            key: key,
            value: jsonEncode({
              'count': 1,
              'last_reset': now,
            }));
        return true;
      }
    } catch (e) {
      return true; // 出错时允许请求
    }
  }
}

/// 安全网络配置常量
class SecureNetworkConstants {
  // 请求配置
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 15);

  // 重试配置
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 1);

  // 频率限制配置
  static const int maxRequestsPerMinute = 100;
  static const Duration rateLimitWindow = Duration(minutes: 1);

  // 安全头部
  static const Map<String, String> securityHeaders = {
    'X-Content-Type-Options': 'nosniff',
    'X-Frame-Options': 'DENY',
    'X-XSS-Protection': '1; mode=block',
    'Strict-Transport-Security': 'max-age=31536000; includeSubDomains',
  };
}
