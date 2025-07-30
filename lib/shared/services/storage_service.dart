import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';

/// 存储服务抽象类
abstract class StorageService {
  // Secure Storage (for sensitive data like tokens)
  Future<void> storeSecure(String key, String value);
  Future<String?> getSecure(String key);
  Future<void> deleteSecure(String key);
  Future<void> clearAllSecure();

  // Additional secure storage methods
  Future<String?> getSecureString(String key);
  Future<void> setSecureString(String key, String value);
  Future<void> removeSecure(String key);

  // Map storage methods
  Future<Map<String, dynamic>?> getMap(String key);
  Future<void> setMap(String key, Map<String, dynamic> value);
  Future<void> setString(String key, String value);

  // Shared Preferences (for simple key-value pairs)
  Future<void> storeString(String key, String value);
  Future<String?> getString(String key);
  Future<void> storeBool(String key, bool value);
  Future<bool?> getBool(String key);
  Future<void> storeInt(String key, int value);
  Future<int?> getInt(String key);
  Future<void> storeDouble(String key, double value);
  Future<double?> getDouble(String key);
  Future<void> remove(String key);
  Future<void> clear();

  // Hive Storage (for complex objects and caching)
  Future<void> storeUser(Map<String, dynamic> user);
  Future<Map<String, dynamic>?> getUser();
  Future<void> deleteUser();

  Future<void> storeSetting(String key, dynamic value);
  Future<T?> getSetting<T>(String key);
  Future<void> deleteSetting(String key);

  Future<void> storeCache(String key, dynamic value, {Duration? ttl});
  Future<T?> getCache<T>(String key);
  Future<void> deleteCache(String key);
  Future<void> clearExpiredCache();

  // Convenience methods
  Future<bool> hasValidToken();
  Future<String?> getToken();
  Future<void> storeToken(String token);
  Future<void> clearAuthData();
}

/// 存储服务实现
class StorageServiceImpl implements StorageService {
  final FlutterSecureStorage _secureStorage;
  final SharedPreferences _sharedPreferences;
  final Box _userBox;
  final Box _settingsBox;
  final Box _cacheBox;

  StorageServiceImpl({
    required FlutterSecureStorage secureStorage,
    required SharedPreferences sharedPreferences,
    required Box userBox,
    required Box settingsBox,
    required Box cacheBox,
  })  : _secureStorage = secureStorage,
        _sharedPreferences = sharedPreferences,
        _userBox = userBox,
        _settingsBox = settingsBox,
        _cacheBox = cacheBox;

  // Secure Storage Implementation
  @override
  Future<void> storeSecure(String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      print('Error storing secure data: $e');
      rethrow;
    }
  }

  @override
  Future<String?> getSecure(String key) async {
    try {
      return await _secureStorage.read(key: key);
    } catch (e) {
      print('Error reading secure data: $e');
      return null;
    }
  }

  @override
  Future<void> deleteSecure(String key) async {
    try {
      await _secureStorage.delete(key: key);
    } catch (e) {
      print('Error deleting secure data: $e');
    }
  }

  @override
  Future<void> clearAllSecure() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e) {
      print('Error clearing secure storage: $e');
    }
  }

  @override
  Future<String?> getSecureString(String key) async {
    return await getSecure(key);
  }

  @override
  Future<void> setSecureString(String key, String value) async {
    await storeSecure(key, value);
  }

  @override
  Future<void> removeSecure(String key) async {
    await deleteSecure(key);
  }

  @override
  Future<Map<String, dynamic>?> getMap(String key) async {
    try {
      final data = _sharedPreferences.getString(key);
      if (data != null) {
        return Map<String, dynamic>.from(
          Map<String, dynamic>.from(
            data as Map<String, dynamic>,
          ),
        );
      }
      return null;
    } catch (e) {
      print('Error reading map data: $e');
      return null;
    }
  }

  @override
  Future<void> setMap(String key, Map<String, dynamic> value) async {
    try {
      await _sharedPreferences.setString(key, value.toString());
    } catch (e) {
      print('Error storing map data: $e');
    }
  }

  @override
  Future<void> setString(String key, String value) async {
    try {
      await _sharedPreferences.setString(key, value);
    } catch (e) {
      print('Error storing string data: $e');
    }
  }

  // Shared Preferences Implementation
  @override
  Future<void> storeString(String key, String value) async {
    try {
      await _sharedPreferences.setString(key, value);
    } catch (e) {
      print('Error storing string: $e');
    }
  }

  @override
  Future<String?> getString(String key) async {
    try {
      return _sharedPreferences.getString(key);
    } catch (e) {
      print('Error reading string: $e');
      return null;
    }
  }

  @override
  Future<void> storeBool(String key, bool value) async {
    try {
      await _sharedPreferences.setBool(key, value);
    } catch (e) {
      print('Error storing bool: $e');
    }
  }

  @override
  Future<bool?> getBool(String key) async {
    try {
      return _sharedPreferences.getBool(key);
    } catch (e) {
      print('Error reading bool: $e');
      return null;
    }
  }

  @override
  Future<void> storeInt(String key, int value) async {
    try {
      await _sharedPreferences.setInt(key, value);
    } catch (e) {
      print('Error storing int: $e');
    }
  }

  @override
  Future<int?> getInt(String key) async {
    try {
      return _sharedPreferences.getInt(key);
    } catch (e) {
      print('Error reading int: $e');
      return null;
    }
  }

  @override
  Future<void> storeDouble(String key, double value) async {
    try {
      await _sharedPreferences.setDouble(key, value);
    } catch (e) {
      print('Error storing double: $e');
    }
  }

  @override
  Future<double?> getDouble(String key) async {
    try {
      return _sharedPreferences.getDouble(key);
    } catch (e) {
      print('Error reading double: $e');
      return null;
    }
  }

  @override
  Future<void> remove(String key) async {
    try {
      await _sharedPreferences.remove(key);
    } catch (e) {
      print('Error removing key: $e');
    }
  }

  @override
  Future<void> clear() async {
    try {
      await _sharedPreferences.clear();
    } catch (e) {
      print('Error clearing shared preferences: $e');
    }
  }

  // Hive Storage Implementation
  @override
  Future<void> storeUser(Map<String, dynamic> user) async {
    try {
      await _userBox.put('current_user', user);
    } catch (e) {
      print('Error storing user: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> getUser() async {
    try {
      final user = _userBox.get('current_user');
      if (user is Map) {
        return Map<String, dynamic>.from(user);
      }
      return null;
    } catch (e) {
      print('Error reading user: $e');
      return null;
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      await _userBox.delete('current_user');
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  @override
  Future<void> storeSetting(String key, dynamic value) async {
    try {
      await _settingsBox.put(key, value);
    } catch (e) {
      print('Error storing setting: $e');
    }
  }

  @override
  Future<T?> getSetting<T>(String key) async {
    try {
      final value = _settingsBox.get(key);
      if (value is T) {
        return value;
      }
      return null;
    } catch (e) {
      print('Error reading setting: $e');
      return null;
    }
  }

  @override
  Future<void> deleteSetting(String key) async {
    try {
      await _settingsBox.delete(key);
    } catch (e) {
      print('Error deleting setting: $e');
    }
  }

  @override
  Future<void> storeCache(String key, dynamic value, {Duration? ttl}) async {
    try {
      final cacheEntry = {
        'value': value,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'ttl': ttl?.inMilliseconds,
      };
      await _cacheBox.put(key, cacheEntry);
    } catch (e) {
      print('Error storing cache: $e');
    }
  }

  @override
  Future<T?> getCache<T>(String key) async {
    try {
      final cacheEntry = _cacheBox.get(key);
      if (cacheEntry is Map) {
        final timestamp = cacheEntry['timestamp'] as int?;
        final ttl = cacheEntry['ttl'] as int?;

        // Check if cache is expired
        if (timestamp != null && ttl != null) {
          final now = DateTime.now().millisecondsSinceEpoch;
          if (now - timestamp > ttl) {
            // Cache expired, delete it
            await _cacheBox.delete(key);
            return null;
          }
        }

        final value = cacheEntry['value'];
        if (value is T) {
          return value;
        }
      }
      return null;
    } catch (e) {
      print('Error reading cache: $e');
      return null;
    }
  }

  @override
  Future<void> deleteCache(String key) async {
    try {
      await _cacheBox.delete(key);
    } catch (e) {
      print('Error deleting cache: $e');
    }
  }

  @override
  Future<void> clearExpiredCache() async {
    try {
      final now = DateTime.now().millisecondsSinceEpoch;
      final keysToDelete = <String>[];

      for (final key in _cacheBox.keys) {
        final cacheEntry = _cacheBox.get(key);
        if (cacheEntry is Map) {
          final timestamp = cacheEntry['timestamp'] as int?;
          final ttl = cacheEntry['ttl'] as int?;

          if (timestamp != null && ttl != null) {
            if (now - timestamp > ttl) {
              keysToDelete.add(key.toString());
            }
          }
        }
      }

      for (final key in keysToDelete) {
        await _cacheBox.delete(key);
      }

      print('Cleared ${keysToDelete.length} expired cache entries');
    } catch (e) {
      print('Error clearing expired cache: $e');
    }
  }

  // Convenience Methods
  @override
  Future<bool> hasValidToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<String?> getToken() async {
    return await getSecure(AppConstants.tokenKey);
  }

  @override
  Future<void> storeToken(String token) async {
    await storeSecure(AppConstants.tokenKey, token);
  }

  @override
  Future<void> clearAuthData() async {
    await deleteSecure(AppConstants.tokenKey);
    await deleteUser();
    await remove(AppConstants.userKey);
  }
}
