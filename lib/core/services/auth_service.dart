// // ignore_for_file: file_names

// import 'dart:developer';
// import 'package:get/get.dart';
// import 'package:quick_job/routes/app_routes.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthService {
//   static const String _tokenKey = 'token';
//   static const String _idKey = 'id';
//   static const String _roleKey = 'role';

//   // Singleton instance for SharedPreferences
//   static late SharedPreferences _preferences;

//   // Private variables to hold token, userId, and role
//   static String? _token;
//   static String? _id;
//   static String? _role;

//   // Initialize SharedPreferences (call this during app startup)
//   static Future<void> init() async {
//     _preferences = await SharedPreferences.getInstance();
//     // Load token, userId, and role from SharedPreferences into private variables
//     _token = _preferences.getString(_tokenKey);
//     _id = _preferences.getString(_idKey);
//     _role = _preferences.getString(_roleKey);
//   }

//   // Save ID
//   static Future<void> saveId({required String id}) async {
//     try {
//       await _preferences.setString(_idKey, id);
//       _id = id;
//     } catch (e) {
//       log('Error saving id: $e');
//     }
//   }

//   // Save Token
//   static Future<void> saveToken({required String token}) async {
//     try {
//       log("Saving token: $token");
//       await _preferences.setString(_tokenKey, token);
//       _token = token;
//     } catch (e) {
//       log('Error saving token: $e');
//     }
//   }

//   // Save Role
//   static Future<void> saveRole({required String role}) async {
//     try {
//       await _preferences.setString(_roleKey, role);
//       _role = role;
//     } catch (e) {
//       log('Error saving role: $e');
//     }
//   }

//   static bool hasToken() {
//     return _preferences.containsKey(_tokenKey);
//   }

//   // Clear authentication data (for logout or clearing auth data)
//   static Future<void> logoutUser() async {
//     try {
//       await _preferences.clear();

//       // Reset private variables
//       _token = null;
//       _id = null;
//       _role = null;

//       // Redirect to the login screen
//       await goToLogin();
//     } catch (e) {
//       log('Error during logout: $e');
//     }
//   }

//   // Navigate to the login screen (e.g., after logout or token expiry)
//   static Future<void> goToLogin() async {
//     Get.offAllNamed(AppRoute.loginScreen);
//   }

//   // Getters
//   static String? get token => _token;
//   static String? get id => _id;
//   static String? get role => _role;
// }

// ignore_for_file: file_names

// import 'dart:developer';
// import 'package:get/get.dart';
// import 'package:quick_job/routes/app_routes.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthService {
//   static const String _tokenKey = 'token';
//   static const String _idKey = 'id';
//   static const String _roleKey = 'role';
//   static const String _profileImageKey = 'profileImage'; // NEW

//   // Singleton instance for SharedPreferences
//   static late SharedPreferences _preferences;

//   // Private variables to hold token, userId, role, and profileImage
//   static String? _token;
//   static String? _id;
//   static String? _role;
//   static String? _profileImage; // NEW

//   // Initialize SharedPreferences (call this during app startup)
//   static Future<void> init() async {
//     _preferences = await SharedPreferences.getInstance();
//     _token = _preferences.getString(_tokenKey);
//     _id = _preferences.getString(_idKey);
//     _role = _preferences.getString(_roleKey);
//     _profileImage = _preferences.getString(_profileImageKey); // NEW
//   }

//   // Save ID
//   static Future<void> saveId({required String id}) async {
//     try {
//       await _preferences.setString(_idKey, id);
//       _id = id;
//     } catch (e) {
//       log('Error saving id: $e');
//     }
//   }

//   // Save Token
//   static Future<void> saveToken({required String token}) async {
//     try {
//       log("Saving token: $token");
//       await _preferences.setString(_tokenKey, token);
//       _token = token;
//     } catch (e) {
//       log('Error saving token: $e');
//     }
//   }

//   // Save Role
//   static Future<void> saveRole({required String role}) async {
//     try {
//       await _preferences.setString(_roleKey, role);
//       _role = role;
//     } catch (e) {
//       log('Error saving role: $e');
//     }
//   }

//   // Save Profile Image Path
//   static Future<void> saveProfileImage(String path) async {
//     try {
//       await _preferences.setString(_profileImageKey, path);
//       _profileImage = path;
//       log("Profile image saved: $path");
//     } catch (e) {
//       log('Error saving profile image: $e');
//     }
//   }

//   // Get Profile Image Path
//   static String get profileImage => _profileImage ?? '';

//   static bool hasToken() {
//     return _preferences.containsKey(_tokenKey);
//   }

//   // Clear authentication data (for logout or clearing auth data)
//   static Future<void> logoutUser() async {
//     try {
//       await _preferences.clear();

//       // Reset private variables
//       _token = null;
//       _id = null;
//       _role = null;
//       // _profileImage = null;

//       // Redirect to the login screen
//       await goToLogin();
//     } catch (e) {
//       log('Error during logout: $e');
//     }
//   }

//   // Navigate to the login screen (e.g., after logout or token expiry)
//   static Future<void> goToLogin() async {
//     Get.offAllNamed(AppRoute.loginScreen);
//   }

//   // Getters
//   static String? get token => _token;
//   static String? get id => _id;
//   static String? get role => _role;

// }

// import 'dart:developer';
// import 'package:get/get.dart';
// import 'package:quick_job/routes/app_routes.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthService {
//   static const String _tokenKey = 'token';
//   static const String _idKey = 'id';
//   static const String _roleKey = 'role';
//   static const String _profileImageKey = 'profileImage';

//   // Singleton instance for SharedPreferences
//   static SharedPreferences? _preferences;

//   // Private variables to hold token, userId, role, and profileImage
//   static String? _token;
//   static String? _id;
//   static String? _role;
//   static String? _profileImage;

//   /// Initialize SharedPreferences (call this during app startup)
//   static Future<void> init() async {
//     _preferences ??= await SharedPreferences.getInstance();
//     _token = _preferences?.getString(_tokenKey);
//     _id = _preferences?.getString(_idKey);
//     _role = _preferences?.getString(_roleKey);
//     _profileImage = _preferences?.getString(_profileImageKey);
//   }

//   /// Save ID
//   static Future<void> saveId({required String id}) async {
//     try {
//       await _preferences?.setString(_idKey, id);
//       _id = id;
//     } catch (e) {
//       log('Error saving id: $e');
//     }
//   }

//   /// Save Token
//   static Future<void> saveToken({required String token}) async {
//     try {
//       log("Saving token: $token");
//       await _preferences?.setString(_tokenKey, token);
//       _token = token;
//     } catch (e) {
//       log('Error saving token: $e');
//     }
//   }

//   /// Save Role
//   static Future<void> saveRole({required String role}) async {
//     try {
//       await _preferences?.setString(_roleKey, role);
//       _role = role;
//     } catch (e) {
//       log('Error saving role: $e');
//     }
//   }

//   /// Save Profile Image Path
//   static Future<void> saveProfileImage(String path) async {
//     try {
//       await _preferences?.setString(_profileImageKey, path);
//       _profileImage = path;
//       log("Profile image saved: $path");
//     } catch (e) {
//       log('Error saving profile image: $e');
//     }
//   }

//   /// Get Profile Image Path
//   static String get profileImage => _profileImage ?? '';

//   /// Check if token exists
//   static bool hasToken() => _preferences?.containsKey(_tokenKey) ?? false;

//   /// Clear authentication data (for logout or clearing auth data)
//   static Future<void> logoutUser() async {
//     try {
//       await _preferences?.clear();

//       _token = null;
//       _id = null;
//       _role = null;
//       _profileImage = null;

//       await goToLogin();
//     } catch (e) {
//       log('Error during logout: $e');
//     }
//   }

//   /// Navigate to the login screen (e.g., after logout or token expiry)
//   static Future<void> goToLogin() async {
//     if (Get.isRegistered<GetxController>()) {
//       // Ensure navigation works even if context is lost
//       Get.offAllNamed(AppRoute.loginScreen);
//     }
//   }

//   // Getters
//   static String? get token => _token;
//   static String? get id => _id;
//   static String? get role => _role;
// }

import 'dart:developer';
import 'package:get/get.dart';
import 'package:quick_job/features/role/views/screens/role_selection_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _tokenKey = 'token';
  static const String _idKey = 'id';
  static const String _roleKey = 'role';
  static const String _profileImageKey = 'profileImage';

  static SharedPreferences? _preferences;

  static String? _token;
  static String? _id;
  static String? _role;
  static String? _profileImage;

  /// MUST be called in main()
  static Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
    _token = _preferences?.getString(_tokenKey);
    _id = _preferences?.getString(_idKey);
    _role = _preferences?.getString(_roleKey);
    _profileImage = _preferences?.getString(_profileImageKey);
    log("user id ; $id");
  }

  static Future<void> saveToken({required String token}) async {
    try {
      await _preferences?.setString(_tokenKey, token);
      _token = token;
    } catch (e) {
      log('Error saving token: $e');
    }
  }

  static Future<void> saveId({required String id}) async {
    try {
      await _preferences?.setString(_idKey, id);
      _id = id;
      log(id.toString());
    } catch (e) {
      log('Error saving id: $e');
    }
  }

  static Future<void> saveRole({required String role}) async {
    try {
      await _preferences?.setString(_roleKey, role);
      _role = role;
    } catch (e) {
      log('Error saving role: $e');
    }
  }

  /// 🔥 PROFILE IMAGE PERSISTS FOREVER
  static Future<void> saveProfileImage(String path) async {
    try {
      await _preferences?.setString(_profileImageKey, path);
      _profileImage = path;
    } catch (e) {
      log('Error saving profile image: $e');
    }
  }

  static String get profileImage => _profileImage ?? '';

  static bool hasToken() => _token != null && _token!.isNotEmpty;

  /// ✅ LOGOUT FIXED
  static Future<void> logoutUser() async {
    try {
      await _preferences?.remove(_tokenKey);
      await _preferences?.remove(_idKey);
      await _preferences?.remove(_roleKey);
      await _preferences?.clear();

      _token = null;
      _id = null;
      _role = null;

      // Get.offAllNamed(AppRoute.loginScreen);
      Get.offAll(() => RoleSelectionScreen());
    } catch (e) {
      log('Logout error: $e');
    }
  }

  // Getters
  static String? get token => _token;
  static String? get id => _id;
  static String? get role => _role;
}
