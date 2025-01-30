import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  // private constructor as I don't want to allow creating an instance of this class itself.
  SharedPrefHelper._();

  // Create a single instance of FlutterSecureStorage with proper options
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      resetOnError: true,
    ),
  );

  /// Removes a value from SharedPreferences with given [key].
  static Future<void> removeData(String key) async {
    debugPrint('SharedPrefHelper : data with key : $key has been removed');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  /// Removes all keys and values in the SharedPreferences
  static Future<void> clearAllData() async {
    debugPrint('SharedPrefHelper : all data has been cleared');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  /// Saves a [value] with a [key] in the SharedPreferences.
  static Future<void> setData(String key, dynamic value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    debugPrint("SharedPrefHelper : setData with key : $key and value : $value");
    switch (value.runtimeType) {
      case const (String):
        await sharedPreferences.setString(key, value);
        break;
      case const (int):
        await sharedPreferences.setInt(key, value);
        break;
      case const (bool):
        await sharedPreferences.setBool(key, value);
        break;
      case const (double):
        await sharedPreferences.setDouble(key, value);
        break;
      default:
        return;
    }
  }

  /// Gets a bool value from SharedPreferences with given [key].
  static Future<bool> getBool(String key) async {
    debugPrint('SharedPrefHelper : getBool with key : $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? false;
  }

  /// Sets a bool value in SharedPreferences with given [key].
  static Future<void> setBool(String key, bool value) async {
    debugPrint('SharedPrefHelper : setBool with key : $key and value : $value');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(key, value);
  }

  /// Gets a double value from SharedPreferences with given [key].
  static Future<double> getDouble(String key) async {
    debugPrint('SharedPrefHelper : getDouble with key : $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key) ?? 0.0;
  }

  /// Sets a double value in SharedPreferences with given [key].
  static Future<void> setDouble(String key, double value) async {
    debugPrint(
        'SharedPrefHelper : setDouble with key : $key and value : $value');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setDouble(key, value);
  }

  /// Gets an int value from SharedPreferences with given [key].
  static Future<int> getInt(String key) async {
    debugPrint('SharedPrefHelper : getInt with key : $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key) ?? 0;
  }

  /// Sets an int value in SharedPreferences with given [key].
  static Future<void> setInt(String key, int value) async {
    debugPrint('SharedPrefHelper : setInt with key : $key and value : $value');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt(key, value);
  }

  /// Gets a String value from SharedPreferences with given [key].
  static Future<String> getString(String key) async {
    debugPrint('SharedPrefHelper : getString with key : $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? '';
  }

  /// Sets a String value in SharedPreferences with given [key].
  static Future<void> setString(String key, String value) async {
    debugPrint(
        'SharedPrefHelper : setString with key : $key and value : $value');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, value);
  }

  /// Saves a [value] with a [key] in the FlutterSecureStorage.
  static Future<void> setSecuredString(String key, String value) async {
    try {
      debugPrint(
          "FlutterSecureStorage : setSecuredString with key : $key and value : $value");
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      debugPrint('SecureStorage error: $e');
      // Reset storage and retry
      await _secureStorage.deleteAll();
      try {
        await _secureStorage.write(key: key, value: value);
      } catch (retryError) {
        debugPrint('SecureStorage retry error: $retryError');
      }
    }
  }

  /// Removes a [key] from the FlutterSecureStorage.
  static Future<void> removeSecuredString(String key) async {
    try {
      debugPrint('FlutterSecureStorage : removeSecuredString with key : $key');
      await _secureStorage.delete(key: key);
    } catch (e) {
      debugPrint('SecureStorage error: $e');
      try {
        await _secureStorage.deleteAll();
      } catch (deleteError) {
        debugPrint('SecureStorage delete error: $deleteError');
      }
    }
  }

  /// Gets a String value from FlutterSecureStorage with given [key].
  static Future<String> getSecuredString(String key) async {
    try {
      debugPrint('FlutterSecureStorage : getSecuredString with key : $key');
      final value = await _secureStorage.read(key: key);
      return value ?? '';
    } catch (e) {
      debugPrint('SecureStorage error: $e');
      // Reset storage on error
      try {
        await _secureStorage.deleteAll();
      } catch (deleteError) {
        debugPrint('SecureStorage delete error: $deleteError');
      }
      return '';
    }
  }

  /// Removes all keys and values in the FlutterSecureStorage
  static Future<void> clearAllSecuredData() async {
    try {
      debugPrint('FlutterSecureStorage : all data has been cleared');
      await _secureStorage.deleteAll();
    } catch (e) {
      debugPrint('SecureStorage error: $e');
    }
  }
}
