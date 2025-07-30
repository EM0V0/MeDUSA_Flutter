import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:cryptography/cryptography.dart';

/// 加密服务抽象类
abstract class EncryptionService {
  /// 生成随机AES密钥
  Future<String> generateAESKey();
  
  /// 加密JSON数据
  Future<Map<String, String>> encryptJson(Map<String, dynamic> data, String base64Key);
  
  /// 解密JSON数据
  Future<Map<String, dynamic>> decryptJson(Map<String, String> encryptedData, String base64Key);
  
  /// 生成随机字符串
  String generateRandomString(int length);
  
  /// 哈希密码
  String hashPassword(String password, String salt);
  
  /// 验证密码
  bool verifyPassword(String password, String salt, String hashedPassword);
  
  /// 生成盐值
  String generateSalt();
}

/// 加密服务实现
class EncryptionServiceImpl implements EncryptionService {
  final AesGcm _aesGcm = AesGcm.with256bits();
  
  @override
  Future<String> generateAESKey() async {
    final secretKey = await _aesGcm.newSecretKey();
    final keyBytes = await secretKey.extractBytes();
    return base64Encode(keyBytes);
  }

  @override
  Future<Map<String, String>> encryptJson(Map<String, dynamic> data, String base64Key) async {
    try {
      // 将数据转换为JSON字符串
      final jsonString = jsonEncode(data);
      final plaintext = utf8.encode(jsonString);
      
      // 从base64密钥创建SecretKey
      final keyBytes = base64Decode(base64Key);
      final secretKey = await _aesGcm.newSecretKeyFromBytes(keyBytes);
      
      // 生成随机nonce (初始化向量)
      final nonce = _aesGcm.newNonce();
      
      // 加密数据
      final secretBox = await _aesGcm.encrypt(
        plaintext,
        secretKey: secretKey,
        nonce: nonce,
      );
      
      // 返回加密结果
      return {
        'iv': base64Encode(nonce),
        'ciphertext': base64Encode(secretBox.cipherText),
        'tag': base64Encode(secretBox.mac.bytes),
      };
    } catch (e) {
      throw EncryptionException('Failed to encrypt JSON: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> decryptJson(Map<String, String> encryptedData, String base64Key) async {
    try {
      // 验证必需字段
      final iv = encryptedData['iv'];
      final ciphertext = encryptedData['ciphertext'];
      final tag = encryptedData['tag'];
      
      if (iv == null || ciphertext == null || tag == null) {
        throw EncryptionException('Missing required encryption fields');
      }
      
      // 解码数据
      final nonceBytes = base64Decode(iv);
      final ciphertextBytes = base64Decode(ciphertext);
      final tagBytes = base64Decode(tag);
      final keyBytes = base64Decode(base64Key);
      
      // 创建SecretKey和SecretBox
      final secretKey = await _aesGcm.newSecretKeyFromBytes(keyBytes);
      final nonce = List<int>.from(nonceBytes);
      final mac = Mac(tagBytes);
      final secretBox = SecretBox(ciphertextBytes, nonce: nonce, mac: mac);
      
      // 解密数据
      final decryptedBytes = await _aesGcm.decrypt(
        secretBox,
        secretKey: secretKey,
      );
      
      // 转换回JSON
      final jsonString = utf8.decode(decryptedBytes);
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      throw EncryptionException('Failed to decrypt JSON: $e');
    }
  }

  @override
  String generateRandomString(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random.secure();
    return String.fromCharCodes(
      Iterable.generate(length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

  @override
  String hashPassword(String password, String salt) {
    final bytes = utf8.encode(password + salt);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  bool verifyPassword(String password, String salt, String hashedPassword) {
    final hash = hashPassword(password, salt);
    return hash == hashedPassword;
  }

  @override
  String generateSalt() {
    return generateRandomString(32);
  }
}

/// 加密异常类
class EncryptionException implements Exception {
  final String message;
  
  const EncryptionException(this.message);
  
  @override
  String toString() => 'EncryptionException: $message';
}

/// 加密工具类
class EncryptionUtils {
  /// 生成安全的随机字节
  static Uint8List generateRandomBytes(int length) {
    final random = Random.secure();
    return Uint8List.fromList(List.generate(length, (_) => random.nextInt(256)));
  }
  
  /// 将字节数组转换为十六进制字符串
  static String bytesToHex(List<int> bytes) {
    return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }
  
  /// 将十六进制字符串转换为字节数组
  static List<int> hexToBytes(String hex) {
    final result = <int>[];
    for (int i = 0; i < hex.length; i += 2) {
      result.add(int.parse(hex.substring(i, i + 2), radix: 16));
    }
    return result;
  }
  
  /// 安全比较两个字符串（防止时序攻击）
  static bool secureStringCompare(String a, String b) {
    if (a.length != b.length) {
      return false;
    }
    
    int result = 0;
    for (int i = 0; i < a.length; i++) {
      result |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    
    return result == 0;
  }
  
  /// 验证Base64字符串格式
  static bool isValidBase64(String value) {
    try {
      base64Decode(value);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  /// 清理敏感字符串内存
  static void clearSensitiveString(StringBuffer buffer) {
    // 清除缓冲区内容
    buffer.clear();
  }
}

/// 加密数据模型
class EncryptedPayload {
  final String iv;
  final String ciphertext;
  final String tag;
  
  const EncryptedPayload({
    required this.iv,
    required this.ciphertext,
    required this.tag,
  });
  
  Map<String, String> toMap() {
    return {
      'iv': iv,
      'ciphertext': ciphertext,
      'tag': tag,
    };
  }
  
  factory EncryptedPayload.fromMap(Map<String, String> map) {
    return EncryptedPayload(
      iv: map['iv'] ?? '',
      ciphertext: map['ciphertext'] ?? '',
      tag: map['tag'] ?? '',
    );
  }
  
  String toJson() => jsonEncode(toMap());
  
  factory EncryptedPayload.fromJson(String source) {
    final map = jsonDecode(source) as Map<String, dynamic>;
    return EncryptedPayload.fromMap(Map<String, String>.from(map));
  }
  
  @override
  String toString() => 'EncryptedPayload(iv: ${iv.substring(0, 8)}..., ciphertext: ${ciphertext.length} chars, tag: ${tag.substring(0, 8)}...)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is EncryptedPayload &&
        other.iv == iv &&
        other.ciphertext == ciphertext &&
        other.tag == tag;
  }
  
  @override
  int get hashCode => iv.hashCode ^ ciphertext.hashCode ^ tag.hashCode;
} 