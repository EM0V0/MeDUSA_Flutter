import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

/// 安全服务抽象类
abstract class SecurityService {
  /// 生物识别认证
  Future<bool> authenticateWithBiometrics();

  /// 检查生物识别是否可用
  Future<bool> isBiometricsAvailable();

  /// 获取可用的生物识别类型
  Future<List<BiometricType>> getAvailableBiometrics();

  /// 证书固定验证
  Future<bool> verifyCertificatePinning(String host, int port);

  /// 生成设备指纹
  Future<String> generateDeviceFingerprint();

  /// 验证设备完整性
  Future<bool> verifyDeviceIntegrity();

  /// 安全密钥生成
  Future<String> generateSecureKey();

  /// 密钥派生函数
  Future<String> deriveKey(String password, String salt, {int iterations = 100000});

  /// 安全随机数生成
  Future<Uint8List> generateSecureRandom(int length);

  /// 内存安全清理
  void secureClear(List<int> data);

  /// 防重放攻击验证
  Future<bool> verifyNonce(String nonce);

  /// 会话管理
  Future<void> createSecureSession();
  Future<bool> validateSession();
  Future<void> destroySession();

  /// 安全日志记录
  void logSecurityEvent(String event, {Map<String, dynamic>? metadata});
}

/// 安全服务实现
class SecurityServiceImpl implements SecurityService {
  final LocalAuthentication _localAuth;
  final FlutterSecureStorage _secureStorage;

  SecurityServiceImpl({
    required LocalAuthentication localAuth,
    required FlutterSecureStorage secureStorage,
  })  : _localAuth = localAuth,
        _secureStorage = secureStorage;

  @override
  Future<bool> authenticateWithBiometrics() async {
    try {
      final isAvailable = await isBiometricsAvailable();
      if (!isAvailable) {
        return false;
      }

      return await _localAuth.authenticate(
        localizedReason: 'Please authenticate to access MeDUSA',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      logSecurityEvent('Biometric authentication failed', metadata: {'error': e.toString()});
      return false;
    }
  }

  @override
  Future<bool> isBiometricsAvailable() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      return isAvailable && isDeviceSupported;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> verifyCertificatePinning(String host, int port) async {
    try {
      // 获取存储的证书哈希
      final storedHash = await _secureStorage.read(key: 'cert_hash_$host');
      if (storedHash == null) {
        // 首次连接，存储证书哈希
        final socket = await SecureSocket.connect(host, port);
        final cert = socket.peerCertificate;
        if (cert != null) {
          final certBytes = cert.der;
          final hash = sha256.convert(certBytes).toString();
          await _secureStorage.write(key: 'cert_hash_$host', value: hash);
          await socket.close();
          return true;
        }
        return false;
      } else {
        // 验证证书哈希
        final socket = await SecureSocket.connect(host, port);
        final cert = socket.peerCertificate;
        if (cert != null) {
          final certBytes = cert.der;
          final currentHash = sha256.convert(certBytes).toString();
          await socket.close();
          return currentHash == storedHash;
        }
        return false;
      }
    } catch (e) {
      logSecurityEvent('Certificate pinning failed', metadata: {'host': host, 'error': e.toString()});
      return false;
    }
  }

  @override
  Future<String> generateDeviceFingerprint() async {
    try {
      // 生成基于设备信息的指纹
      final deviceInfo = await _getDeviceInfo();
      final fingerprint = sha256.convert(utf8.encode(deviceInfo)).toString();
      return fingerprint;
    } catch (e) {
      return '';
    }
  }

  Future<String> _getDeviceInfo() async {
    // 这里应该集成设备信息获取库
    // 暂时返回基本信息
    return 'MeDUSA_Device_${DateTime.now().millisecondsSinceEpoch}';
  }

  @override
  Future<bool> verifyDeviceIntegrity() async {
    try {
      // 检查应用完整性
      final storedFingerprint = await _secureStorage.read(key: 'device_fingerprint');
      final currentFingerprint = await generateDeviceFingerprint();

      if (storedFingerprint == null) {
        // 首次运行，存储指纹
        await _secureStorage.write(key: 'device_fingerprint', value: currentFingerprint);
        return true;
      }

      return storedFingerprint == currentFingerprint;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> generateSecureKey() async {
    try {
      final random = await generateSecureRandom(32);
      return base64Encode(random);
    } catch (e) {
      throw Exception('Failed to generate secure key');
    }
  }

  @override
  Future<String> deriveKey(String password, String salt, {int iterations = 100000}) async {
    try {
      // 使用PBKDF2进行密钥派生
      final key = await _pbkdf2(password, salt, iterations);
      return base64Encode(key);
    } catch (e) {
      throw Exception('Failed to derive key');
    }
  }

  Future<Uint8List> _pbkdf2(String password, String salt, int iterations) async {
    // 简化的PBKDF2实现
    final passwordBytes = utf8.encode(password);
    final saltBytes = utf8.encode(salt);

    var key = Uint8List.fromList(passwordBytes + saltBytes);
    for (int i = 0; i < iterations; i++) {
      key = Uint8List.fromList(sha256.convert(key).bytes);
    }

    return key;
  }

  @override
  Future<Uint8List> generateSecureRandom(int length) async {
    try {
      final random = Uint8List(length);
      final randomGenerator = Random.secure();
      for (int i = 0; i < length; i++) {
        random[i] = randomGenerator.nextInt(256);
      }
      return random;
    } catch (e) {
      throw Exception('Failed to generate secure random');
    }
  }

  @override
  void secureClear(List<int> data) {
    // 安全清除内存中的数据
    for (int i = 0; i < data.length; i++) {
      data[i] = 0;
    }
  }

  @override
  Future<bool> verifyNonce(String nonce) async {
    try {
      final usedNonces = await _secureStorage.read(key: 'used_nonces');
      final nonces = usedNonces != null ? jsonDecode(usedNonces) as List : [];

      if (nonces.contains(nonce)) {
        return false; // 重放攻击检测
      }

      // 添加nonce到已使用列表
      nonces.add(nonce);
      if (nonces.length > 1000) {
        nonces.removeAt(0); // 保持列表大小
      }

      await _secureStorage.write(key: 'used_nonces', value: jsonEncode(nonces));
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> createSecureSession() async {
    try {
      final sessionId = await generateSecureKey();
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      await _secureStorage.write(key: 'session_id', value: sessionId);
      await _secureStorage.write(key: 'session_timestamp', value: timestamp.toString());

      logSecurityEvent('Secure session created', metadata: {'session_id': sessionId});
    } catch (e) {
      logSecurityEvent('Failed to create secure session', metadata: {'error': e.toString()});
    }
  }

  @override
  Future<bool> validateSession() async {
    try {
      final sessionId = await _secureStorage.read(key: 'session_id');
      final timestamp = await _secureStorage.read(key: 'session_timestamp');

      if (sessionId == null || timestamp == null) {
        return false;
      }

      final sessionTime = int.parse(timestamp);
      final now = DateTime.now().millisecondsSinceEpoch;
      final sessionAge = now - sessionTime;

      // 会话超时时间：8小时
      const sessionTimeout = 8 * 60 * 60 * 1000;

      if (sessionAge > sessionTimeout) {
        await destroySession();
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> destroySession() async {
    try {
      await _secureStorage.delete(key: 'session_id');
      await _secureStorage.delete(key: 'session_timestamp');

      logSecurityEvent('Session destroyed');
    } catch (e) {
      logSecurityEvent('Failed to destroy session', metadata: {'error': e.toString()});
    }
  }

  @override
  void logSecurityEvent(String event, {Map<String, dynamic>? metadata}) {
    // 安全事件日志记录
    final timestamp = DateTime.now().toIso8601String();
    final logEntry = {
      'timestamp': timestamp,
      'event': event,
      'metadata': metadata ?? {},
    };

    // 这里应该集成到日志系统
    print('SECURITY_LOG: ${jsonEncode(logEntry)}');
  }
}

/// 安全配置常量
class SecurityConstants {
  // 生物识别配置
  static const String biometricReason = 'Please authenticate to access MeDUSA';
  static const Duration biometricTimeout = Duration(seconds: 30);

  // 会话配置
  static const Duration sessionTimeout = Duration(hours: 8);
  static const int maxLoginAttempts = 5;
  static const Duration lockoutDuration = Duration(minutes: 15);

  // 加密配置
  static const int keyDerivationIterations = 100000;
  static const int secureRandomLength = 32;

  // 证书固定配置
  static const List<String> pinnedHosts = [
    'api.medusa.com',
    'localhost',
  ];

  // 安全存储键
  static const String sessionIdKey = 'session_id';
  static const String sessionTimestampKey = 'session_timestamp';
  static const String deviceFingerprintKey = 'device_fingerprint';
  static const String usedNoncesKey = 'used_nonces';
}
