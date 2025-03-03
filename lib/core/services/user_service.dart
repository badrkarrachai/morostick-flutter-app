import 'package:flutter/foundation.dart';
import 'package:morostick/core/data/models/user_model.dart';
import 'dart:convert';
import 'package:morostick/core/helpers/shared_pref_helper.dart';

class UserService extends ChangeNotifier {
  User? _currentUser;
  static const String _userKey = 'secured_user_data';

  User? get currentUser => _currentUser;

  // Load user from secure storage
  Future<void> loadUser() async {
    try {
      final userJson = await SharedPrefHelper.getSecuredString(_userKey);
      if (userJson.isNotEmpty) {
        _currentUser = User.fromJson(json.decode(userJson));
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading user: $e');
      await clearUser();
    }
  }

  // Save user to secure storage
  Future<void> saveUser(User user) async {
    try {
      _currentUser = user;
      final userJson = json.encode(user.toJson());
      await SharedPrefHelper.setSecuredString(_userKey, userJson);
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving user: $e');
      rethrow;
    }
  }

  // Clear user data
  Future<void> clearUser() async {
    try {
      _currentUser = null;
      await SharedPrefHelper.removeSecuredString(_userKey);
      notifyListeners();
    } catch (e) {
      debugPrint('Error clearing user: $e');
      await SharedPrefHelper.clearAllSecuredData();
    }
  }

  Future<void> updateUser(Map<String, dynamic> updates) async {
    if (_currentUser != null) {
      try {
        // Start with the current user's JSON representation
        final Map<String, dynamic> currentUserJson = _currentUser!.toJson();

        // Create a new map for the updates
        final Map<String, dynamic> finalUpdates = {};

        // Process each update
        updates.forEach((key, value) {
          if (value == null) {
            finalUpdates[key] = null;
          } else if (key == 'preferences' && value is Map<String, dynamic>) {
            // Handle preferences update
            final currentPrefs =
                currentUserJson['preferences'] as Map<String, dynamic>;
            finalUpdates[key] = {...currentPrefs, ...value};
          } else if (key == 'notificationSettings' &&
              value is Map<String, dynamic>) {
            // Handle notification settings update
            final currentSettings =
                currentUserJson['notificationSettings'] as Map<String, dynamic>;
            finalUpdates[key] = {...currentSettings, ...value};
          } else if (key == 'avatar') {
            // Handle avatar update
            if (value is Avatar) {
              finalUpdates[key] = value.toJson();
            } else if (value is Map<String, dynamic>) {
              finalUpdates[key] = value;
            } else if (value is String) {
              // Create a new Avatar object with the URL string
              finalUpdates[key] = {'url': value, 'isDeleted': false};
            }
          } else if (key == 'cover' || key == 'coverImage') {
            // Use 'coverImage' as the key in finalUpdates regardless of input key
            if (value is Avatar) {
              finalUpdates['coverImage'] = value.toJson();
            } else if (value is Map<String, dynamic>) {
              finalUpdates['coverImage'] = value;
            } else if (value is String) {
              finalUpdates['coverImage'] = {'url': value, 'isDeleted': false};
            }
          } else {
            finalUpdates[key] = value;
          }
        });

        // Merge the updates with current user data
        final Map<String, dynamic> mergedData = {
          ...currentUserJson,
          ...finalUpdates,
        };

        // Create new user instance with merged data
        final updatedUser = User.fromJson(mergedData);
        await saveUser(updatedUser);
      } catch (e) {
        debugPrint('Error updating user: $e');
        rethrow;
      }
    }
  }

  bool get hasUser => _currentUser != null;
  String? get userId => _currentUser?.id;
  String? get userRole => _currentUser?.role;
  bool get isVerified => _currentUser?.isActivated ?? false;
  Preferences? get userPreferences => _currentUser?.preferences;
}
