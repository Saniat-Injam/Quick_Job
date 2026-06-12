import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// class GoogleAuthService {
//   // Google Sign In
//   signInWithGoogle() async {
//     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

//     final GoogleSignInAuthentication gAuth = await gUser!.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: gAuth.accessToken,
//       idToken: gAuth.idToken,
//     );

//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }
// }

// class GoogleAuthService {
//   Future<UserCredential?> signInWithGoogle() async {
//     try {
//       final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

//       final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//       if (googleUser == null) return null;

//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       return await FirebaseAuth.instance.signInWithCredential(credential);
//     } catch (e) {
//       print("Google Sign-In Error: $e");
//       return null;
//     }
//   }
// }

// import 'dart:developer';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';
// import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
// import 'package:quick_job/core/common/widgets/loading_progress_indicator.dart';
// import 'package:quick_job/core/services/auth_service.dart';
// import 'package:quick_job/core/services/network_caller.dart';
// import 'package:quick_job/core/utils/constants/app_urls.dart';
// import 'package:quick_job/core/utils/logging/logger.dart';
// import 'package:quick_job/features/navbar/views/screens/navbar_screen.dart';

// class GoogleAuthService {
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//   // Get current User
//   User? getCurrentUser() {
//     return firebaseAuth.currentUser;
//   }

//   Future<UserCredential?> signInWithGoogle() async {
//     try {
//       // Begin interactive sign in process
//       await GoogleSignIn().signOut();
//       log("==================Here 1================");
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       if (googleUser == null) {
//         return null;
//       }

//       log("==================Here 2================");
//       // Obtain auth details from request
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       log("==================Here 3================");
//       // If both tokens are missing, do NOT create a credential
//       final String? accessToken = googleAuth.accessToken;
//       final String? idToken = googleAuth.idToken;
//       if ((accessToken == null || accessToken.isEmpty) &&
//           (idToken == null || idToken.isEmpty)) {
//         // This can happen if the flow was interrupted — treat as cancel/failure
//         return null;
//       }

//       log("==================Here 4================");

//       // Create Firebase credential and sign in for User
//       final OAuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: accessToken,
//         idToken: idToken,
//       );

//       log("==================Here 5================");
//       // finally sign in user with credential
//       final credentials = await firebaseAuth.signInWithCredential(credential);
//       log(credentials.user?.email.toString() ?? "");
//       return await firebaseAuth.signInWithCredential(credential);
//     } catch (e) {
//       log('Google sign-in error: $e');
//       return null;
//     }
//   }

//   // Sign In
//   Future<void> socialLoginUser() async {
//     String? fcmToken = "";
//     try {
//       fcmToken = await FirebaseMessaging.instance.getToken();
//     } catch (error) {
//       log("Failed");
//     }
//     try {
//       loadingProgressIndicator();
//       final credentials = await signInWithGoogle();
//       if (credentials?.user == null) {
//         if (Get.isDialogOpen ?? false) {
//           Get.back();
//         }
//         AppSnackBar.showError("Google account not found!");
//         return;
//       }
//       final body = {
//         "email": credentials?.user?.email,
//         "logInProcess": "GOOGLE",
//         "fcmToken": fcmToken ?? "",
//       };
//       log("Fcm token is : $fcmToken");
//       final response = await NetworkCaller().postRequest(
//         AppUrls.googleLogin,
//         body: body,
//       );
//       if (Get.isDialogOpen ?? false) {
//         Get.back();
//       }
//       if (response.isSuccess) {
//         final data = response.responseData;
//         AppSnackBar.showSuccess("Google login suessfull!");
//         final token = data['data']['accessToken'];
//         log(token);
//         await AuthService.saveToken(token: token);

//         Get.offAll(() => NavBarScreen());
//       } else if (response.statusCode == 404) {
//         AppSnackBar.showError("User not found this email!");
//       } else {
//         AppSnackBar.showError("Error : ${response.errorMessage}");
//         AppLoggerHelper.error("Error : ${response.errorMessage}");
//       }
//     } catch (e) {
//       AppSnackBar.showError("Api Error : $e");
//       AppLoggerHelper.error("Api Error : $e");
//     }
//   }

//   // Sign Up
//   Future<void> signUpWithGoogle() async {
//     String? fcmToken = "";
//     try {
//       fcmToken = await FirebaseMessaging.instance.getToken();
//     } catch (error) {
//       log("Fcm token get faild!");
//     }
//     try {
//       loadingProgressIndicator();
//       final credentials = await signInWithGoogle();
//       if (credentials?.user == null) {
//         if (Get.isDialogOpen ?? false) {
//           Get.back();
//         }
//         AppSnackBar.showError("Google account not found!");
//         return;
//       }
//       final body = {
//         "fullName": credentials?.user?.displayName ?? "",
//         "phoneNumber": credentials?.user?.phoneNumber ?? '',
//         "email": credentials?.user?.email,
//         "logInProcess": "GOOGLE",
//         "fcmToken": fcmToken ?? '',
//       };
//       log("Fcm for google signup : $fcmToken");
//       final response = await NetworkCaller().postRequest(
//         AppUrls.signUp,
//         body: body,
//       );
//       if (Get.isDialogOpen ?? false) {
//         Get.back();
//       }
//       if (response.isSuccess) {
//         final data = response.responseData;
//         AppSnackBar.showSuccess("Google singup suessfull!");
//         final token = data['data']['accessToken'];
//         log(token);
//         await AuthService.saveToken(token: token);
//         Get.to(() => NavBarScreen());
//       } else if (response.statusCode == 400) {
//         AppSnackBar.showError("User already exists");
//       } else {
//         AppSnackBar.showError("Error : ${response.errorMessage}");
//         AppLoggerHelper.error("Error : ${response.errorMessage}");
//       }
//     } catch (e) {
//       AppSnackBar.showError("Api Error : $e");
//       AppLoggerHelper.error("Api Error : $e");
//     }
//   }
// }

// ignore_for_file: file_names

// import 'dart:developer';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
// import 'package:quick_job/core/services/network_caller.dart';
// import 'package:quick_job/core/services/auth_service.dart';
// import 'package:quick_job/core/utils/constants/app_urls.dart';
// import 'package:quick_job/core/utils/logging/logger.dart';

// class GoogleAuthService extends GetxService {
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   // Sign in with Google
//   Future<GoogleSignInAccount?> signInWithGoogle() async {
//     try {
//       final account = await _googleSignIn.signIn();
//       return account;
//     } catch (e) {
//       log("Google Sign In Error: $e");
//       return null;
//     }
//   }

//   // Sign out
//   Future<void> signOut() async {
//     try {
//       await _googleSignIn.signOut();
//       //await AuthService.clearToken();
//       Get.offAllNamed('/loginScreen');
//     } catch (e) {
//       log("Google Sign Out Error: $e");
//     }
//   }

//   // Social login API call
//   Future<void> socialLoginUser() async {
//     String? fcmToken = "";
//     try {
//       fcmToken = await FirebaseMessaging.instance.getToken();
//     } catch (e) {
//       log("FCM token fetch failed: $e");
//     }

//     try {
//       // Show loading dialog
//       if (!(Get.isDialogOpen ?? false)) {
//         Get.dialog(
//           const Center(child: CircularProgressIndicator()),
//           barrierDismissible: false,
//         );
//       }

//       // Google sign in
//       final credentials = await signInWithGoogle();
//       if (credentials == null) {
//         if (Get.isDialogOpen ?? false) Get.back();
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           AppSnackBar.showError("Google account not found!");
//         });
//         return;
//       }

//       final body = {
//         "email": credentials.email,
//         "fullName": credentials.displayName ?? "Anonymous",
//         "socialLoginType": "GOOGLE",
//         "appleId": "",
//         "profileImage": credentials.photoUrl ?? "",
//         "fcmToken": fcmToken ?? "",
//         "promoCodes": [], // Ensure this is an array, not string
//       };

//       log("Social Login Body: $body");

//       final response = await NetworkCaller().postRequest(
//         AppUrls.googleLogin,
//         body: body,
//       );

//       // Close loading dialog
//       if (Get.isDialogOpen ?? false) Get.back();

//       if (response.isSuccess) {
//         final data = response.responseData["result"];
//         final token = data["accessToken"];
//         await AuthService.saveToken(token: token);

//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           AppSnackBar.showSuccess("Login successful!");
//         });

//         // Navigate to main app screen
//         Get.offAllNamed('/navBarScreen');
//       } else {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           AppSnackBar.showError(
//             response.errorMessage ?? "There was an issue with your request.",
//           );
//         });
//         AppLoggerHelper.error("Error: ${response.errorMessage}");
//       }
//     } catch (e) {
//       if (Get.isDialogOpen ?? false) Get.back();
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         AppSnackBar.showError("API Error: $e");
//       });
//       AppLoggerHelper.error("API Error: $e");
//     }
//   }
// }

// import 'dart:developer';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
// import '../../../core/models/response_data.dart';
// import '../../../core/services/Auth_service.dart';
// import '../../../core/services/network_caller.dart';
// import '../../../core/utils/constants/app_urls.dart';
// import '../../../routes/app_routes.dart';

// class GoogleAuthService {
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   final NetworkCaller _networkCaller = NetworkCaller();

//   // Get current User
//   User? getCurrentUser() => firebaseAuth.currentUser;

//   /// Google Sign-In
//   Future<UserCredential?> signInWithGoogle() async {
//     try {
//       log("================== Google Sign-In Start ================");

//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       if (googleUser == null) {
//         log("Google Sign-In canceled by user.");
//         return null;
//       }

//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final String? accessToken = googleAuth.accessToken;
//       final String? idToken = googleAuth.idToken;

//       if ((accessToken == null || accessToken.isEmpty) &&
//           (idToken == null || idToken.isEmpty)) {
//         log("Google Sign-In tokens are missing.");
//         return null;
//       }

//       final OAuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: accessToken,
//         idToken: idToken,
//       );

//       return await firebaseAuth.signInWithCredential(credential);
//     } catch (e) {
//       log('Google Sign-In error: $e');
//       AppSnackBar.showError("Google Sign-In failed. Please try again.");
//       return null;
//     }
//   }

//   /// Send Google user data to backend
//   Future<void> sendGoogleUserDataToBackend({
//     String defaultRole = "JOB_SEEKERS",
//   }) async {
//     try {
//       final user = getCurrentUser();
//       if (user == null) {
//         AppSnackBar.showError("Google Sign-In was cancelled.");
//         return;
//       }

//       final fcmToken = await FirebaseMessaging.instance.getToken();

//       final Map<String, dynamic> requestBody = {
//         "email": user.email,
//         "name": user.displayName ?? (user.email?.split('@').first ?? 'User'),
//         "role": defaultRole,
//         "fcmToken": fcmToken,
//         "profileImage": user.photoURL ?? "", // optional
//       };

//       final ResponseData response = await _networkCaller.postRequest(
//         AppUrls.googleLogin,
//         body: requestBody,
//       );

//       if (response.isSuccess && response.responseData != null) {
//         final data = response.responseData;

//         final String? accessToken = data['accessToken']?.toString();
//         final String userRole = (data['role'] ?? defaultRole).toString();
//         final String? refreshToken = data['refreshToken']?.toString();
//         final String? profileImage =
//             data['profileImage']?.toString() ?? user.photoURL;

//         if (accessToken == null || accessToken.isEmpty) {
//           AppSnackBar.showError("Missing access token from server.");
//           return;
//         }

//         // Save data in AuthService
//         await AuthService.saveToken(token: accessToken);
//         await AuthService.saveRole(role: userRole);
//         if (refreshToken != null && refreshToken.isNotEmpty) {
//           await AuthService.saveId(id: data['id']?.toString() ?? "");
//           await AuthService.saveProfileImage(profileImage ?? "");
//         }

//         AppSnackBar.showSuccess("Login successful!");

//         // Navigate based on role
//         final normalizedRole = userRole.toUpperCase();
//         switch (normalizedRole) {
//           case "JOB_SEEKERS":
//             Get.offAllNamed(AppRoute.bottomNavbar);
//             break;
//           case "EMPLOYER":
//             Get.offAllNamed(AppRoute.bottomNavbar); // adjust if different route
//             break;
//           default:
//             Get.offAllNamed(AppRoute.bottomNavbar);
//         }

//         return;
//       }

//       // Handle errors from backend
//       if (response.statusCode == 404) {
//         AppSnackBar.showError("User not found!");
//       } else if (response.statusCode == 403) {
//         AppSnackBar.showError("Access denied!");
//       } else {
//         AppSnackBar.showError(
//           response.errorMessage.isNotEmpty
//               ? response.errorMessage
//               : "Internet Issue",
//         );
//       }
//     } catch (e) {
//       AppSnackBar.showError("Something went wrong: $e");
//       log('Error sending Google user data: $e');
//     }
//   }
// }

// import 'dart:developer';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
// import '../../../core/models/response_data.dart';
// import '../../../core/services/Auth_service.dart';
// import '../../../core/services/network_caller.dart';
// import '../../../core/utils/constants/app_urls.dart';
// import '../../../routes/app_routes.dart';

// class GoogleAuthService {
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   final NetworkCaller _networkCaller = NetworkCaller();

//   /// GoogleSignIn instance
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: ['email', 'profile'], // Request email and profile
//   );

//   /// Get current Firebase user
//   User? getCurrentUser() => firebaseAuth.currentUser;

//   /// Google Sign-In
//   Future<UserCredential?> signInWithGoogle() async {
//     try {
//       log("================== Google Sign-In Start ================");

//       // Force account picker by signing out first
//       await _googleSignIn.signOut();

//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         log("Google Sign-In canceled by user.");
//         AppSnackBar.showError("Google Sign-In canceled.");
//         return null;
//       }

//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final String? accessToken = googleAuth.accessToken;
//       final String? idToken = googleAuth.idToken;

//       if ((accessToken == null || accessToken.isEmpty) &&
//           (idToken == null || idToken.isEmpty)) {
//         log("Google Sign-In tokens are missing.");
//         AppSnackBar.showError("Failed to retrieve Google tokens.");
//         return null;
//       }

//       final OAuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: accessToken,
//         idToken: idToken,
//       );

//       final UserCredential userCredential = await firebaseAuth
//           .signInWithCredential(credential);

//       log("Google Sign-In successful: ${userCredential.user?.email}");
//       return userCredential;
//     } catch (e) {
//       log('Google Sign-In error: $e');
//       AppSnackBar.showError("Google Sign-In failed. Please try again.");
//       return null;
//     }
//   }

//   /// Send Google user data to backend
//   Future<void> sendGoogleUserDataToBackend({
//     String defaultRole = "JOB_SEEKERS",
//   }) async {
//     try {
//       final user = getCurrentUser();
//       if (user == null) {
//         AppSnackBar.showError("Google Sign-In was cancelled.");
//         return;
//       }

//       final fcmToken = await FirebaseMessaging.instance.getToken();

//       final Map<String, dynamic> requestBody = {
//         "email": user.email,
//         "name": user.displayName ?? (user.email?.split('@').first ?? 'User'),
//         "role": defaultRole,
//         "fcmToken": fcmToken,
//         "profileImage": user.photoURL ?? "",
//       };

//       log("Sending Google user data to backend: $requestBody");

//       final ResponseData response = await _networkCaller.postRequest(
//         AppUrls.googleLogin,
//         body: requestBody,
//       );

//       if (response.isSuccess && response.responseData != null) {
//         final data = response.responseData;

//         final String? accessToken = data['accessToken']?.toString();
//         final String userRole = (data['role'] ?? defaultRole).toString();
//         final String? refreshToken = data['refreshToken']?.toString();
//         final String? profileImage =
//             data['profileImage']?.toString() ?? user.photoURL;

//         if (accessToken == null || accessToken.isEmpty) {
//           AppSnackBar.showError("Missing access token from server.");
//           return;
//         }

//         // Save data in AuthService
//         await AuthService.saveToken(token: accessToken);
//         await AuthService.saveRole(role: userRole);
//         if (refreshToken != null && refreshToken.isNotEmpty) {
//           await AuthService.saveId(id: data['id']?.toString() ?? "");
//           await AuthService.saveProfileImage(profileImage ?? "");
//         }

//         AppSnackBar.showSuccess("Login successful!");

//         // Navigate based on role
//         final normalizedRole = userRole.toUpperCase();
//         switch (normalizedRole) {
//           case "JOB_SEEKERS":
//             Get.offAllNamed(AppRoute.bottomNavbar);
//             break;
//           case "EMPLOYER":
//             Get.offAllNamed(AppRoute.bottomNavbar);
//             break;
//           default:
//             Get.offAllNamed(AppRoute.bottomNavbar);
//         }

//         return;
//       }

//       // Handle backend errors
//       if (response.statusCode == 404) {
//         AppSnackBar.showError("User not found!");
//       } else if (response.statusCode == 403) {
//         AppSnackBar.showError("Access denied!");
//       } else {
//         AppSnackBar.showError(
//           response.errorMessage.isNotEmpty
//               ? response.errorMessage
//               : "Internet Issue",
//         );
//       }
//     } catch (e) {
//       AppSnackBar.showError("Something went wrong: $e");
//       log('Error sending Google user data: $e');
//     }
//   }
// }

// import 'dart:developer';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';
// import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
// import '../../../core/models/response_data.dart';
// import '../../../core/services/Auth_service.dart';
// import '../../../core/services/network_caller.dart';
// import '../../../core/utils/constants/app_urls.dart';
// import '../../../routes/app_routes.dart';

// class GoogleAuthService {
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   final NetworkCaller _networkCaller = NetworkCaller();

//   /// GoogleSignIn instance
//   final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

//   /// Get current Firebase user
//   User? getCurrentUser() => firebaseAuth.currentUser;

//   /// Google Sign-In
//   Future<UserCredential?> signInWithGoogle() async {
//     try {
//       log("================== Google Sign-In Start ================");

//       // Force account picker by signing out first
//       await _googleSignIn.signOut();

//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         log("Google Sign-In canceled by user.");
//         AppSnackBar.showError("Google Sign-In canceled.");
//         return null;
//       }

//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       if ((googleAuth.accessToken == null || googleAuth.accessToken!.isEmpty) &&
//           (googleAuth.idToken == null || googleAuth.idToken!.isEmpty)) {
//         log("Google Sign-In tokens are missing.");
//         AppSnackBar.showError("Failed to retrieve Google tokens.");
//         return null;
//       }

//       final OAuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       final UserCredential userCredential = await firebaseAuth
//           .signInWithCredential(credential);

//       log("Google Sign-In successful: ${userCredential.user?.email}");
//       return userCredential;
//     } catch (e) {
//       log('Google Sign-In error: $e');
//       AppSnackBar.showError("Google Sign-In failed. Please try again.");
//       return null;
//     }
//   }

//   /// Send Google user data to backend
//   Future<void> sendGoogleUserDataToBackend({
//     String defaultRole = "JOB_SEEKERS",
//   }) async {
//     try {
//       final user = getCurrentUser();
//       if (user == null) {
//         AppSnackBar.showError("Google Sign-In was cancelled.");
//         return;
//       }

//       final fcmToken = await FirebaseMessaging.instance.getToken();

//       final Map<String, dynamic> requestBody = {
//         "email": user.email,
//         "name": user.displayName ?? (user.email?.split('@').first ?? 'User'),
//         "role": defaultRole,
//         "fcmToken": fcmToken,
//         "profileImage": user.photoURL ?? "",
//       };

//       log("Sending Google user data to backend: $requestBody");

//       final ResponseData response = await _networkCaller.postRequest(
//         AppUrls.googleLogin,
//         body: requestBody,
//       );

//       if (response.isSuccess && response.responseData != null) {
//         final data = response.responseData['result'];
//         log("I am here!");

//         final String? accessToken = data['accessToken']?.toString();
//         final String userRole = (data['role'] ?? defaultRole).toString();

//         if (accessToken == null || accessToken.isEmpty) {
//           AppSnackBar.showError("Missing access token from server.");
//           return;
//         }

//         // Save data in AuthService
//         await AuthService.saveToken(token: accessToken);

//         await AuthService.saveRole(role: userRole);

//         AppSnackBar.showSuccess(
//           "Saved token is: ${AuthService.token.toString()}",
//         );
//         AppSnackBar.showSuccess("Login successful!");

//         // Navigate based on role
//         Get.offAllNamed(AppRoute.bottomNavbar);
//         return;
//       }

//       // Handle backend errors
//       AppSnackBar.showError(
//         response.errorMessage.isNotEmpty
//             ? response.errorMessage
//             : "Something went wrong. Try again.",
//       );
//     } catch (e) {
//       AppSnackBar.showError("Something went wrong: $e");
//       log('Error sending Google user data: $e');
//     }
//   }
// }

import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/common/widgets/app_snack_bar.dart';
import 'package:quick_job/core/common/widgets/loading_progress_indicator.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/core/services/network_caller.dart';
import 'package:quick_job/core/utils/constants/app_urls.dart';
import 'package:quick_job/core/utils/logging/logger.dart';
import 'package:quick_job/features/profile_flow/employer_edit_profile/views/employer_edit_profile_screen.dart';
import 'package:quick_job/features/profile_flow/job_seeker_edit_profile/views/screens/job_seeker_edit_profile_screen.dart';
import 'package:quick_job/routes/app_routes.dart';

class GoogleLoginSignup {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Get current User
  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Begin interactive sign in process
      await GoogleSignIn().signOut();
      log("==================Here 1================");
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }

      log("==================Here 2================");
      // Obtain auth details from request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      log("==================Here 3================");
      // If both tokens are missing, do NOT create a credential
      final String? accessToken = googleAuth.accessToken;
      final String? idToken = googleAuth.idToken;
      if ((accessToken == null || accessToken.isEmpty) &&
          (idToken == null || idToken.isEmpty)) {
        // This can happen if the flow was interrupted — treat as cancel/failure
        return null;
      }

      log("==================Here 4================");

      // Create Firebase credential and sign in for User
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      log("==================Here 5================");
      // finally sign in user with credential
      final credentials = await firebaseAuth.signInWithCredential(credential);
      log(credentials.user?.email.toString() ?? "");
      return await firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      log('Google sign-in error: $e');
      return null;
    }
  }

  Future<void> socialLoginUser({required String role}) async {
    String? fcmToken = "";
    try {
      fcmToken = await FirebaseMessaging.instance.getToken();
    } catch (error) {
      log("Failed");
    }
    try {
      loadingProgressIndicator();
      final credentials = await signInWithGoogle();
      if (credentials?.user == null) {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        AppSnackBar.showError("Google account not found!");
        return;
      }
      final body = {
        "email": credentials?.user?.email,
        "role": AuthService.role.toString(),
        "fcmToken": fcmToken ?? "",
        "socialLoginType": "GOOGLE",
        "fullName": credentials?.user?.displayName,
      };

      log("Fcm token is : $fcmToken");
      final response = await NetworkCaller().postRequest(
        AppUrls.googleLogin,
        body: body,
      );

      if (response.isSuccess) {
        final data = response.responseData;
        // AppSnackBar.showSuccess("Google login successful!");
        final token = data['result']['accessToken'];
        final role = data['result']['userInfo']['role'] ?? "EMPLOYEER";
        final isProfile = data['result']['userInfo']['isProfile'] ?? false;
        log(token.toString());
        log(role.toString());
        log(isProfile.toString());
        await AuthService.saveToken(token: token);
        await AuthService.saveRole(role: role);
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }

        if (isProfile == false) {
          log("I am is profile=====================");

          log(role.toString());
          if (role.toString() == 'JOB_SEEKERS') {
            Get.to(() => JobSeekerEditProfileScreen());
          } else {
            Get.to(() => EmployerEditProfileScreen());
          }
        } else {
          log("I am is  dfjskldfjkl;");
          Get.offAllNamed(
            AppRoute.bottomNavbar,
            arguments: {'role': role.toString()},
          );
        }

        // Get.offAll(() => NavBarScreen());
      } else if (response.statusCode == 404) {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        AppSnackBar.showError("User not found this email!");
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        AppSnackBar.showError("Error : ${response.errorMessage}");
        AppLoggerHelper.error("Error : ${response.errorMessage}");
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      AppSnackBar.showError("Api Error : $e");
      AppLoggerHelper.error("Api Error : $e");
    }
  }

  // Future<void> signUpWithGoogle({required String role}) async {
  //   String? fcmToken = "";
  //   try {
  //     fcmToken = await FirebaseMessaging.instance.getToken();
  //   } catch (error) {
  //     log("Fcm token get faild!");
  //   }
  //   try {
  //     loadingProgressIndicator();
  //     final credentials = await signInWithGoogle();
  //     if (credentials?.user == null) {
  //       if (Get.isDialogOpen ?? false) {
  //         Get.back();
  //       }
  //       AppSnackBar.showError("Google account not found!");
  //       return;
  //     }
  //     final body = {
  //       "fullName": credentials?.user?.displayName ?? "",
  //       "phoneNumber": credentials?.user?.phoneNumber ?? '',
  //       "email": credentials?.user?.email,
  //       // "logInProcess": "GOOGLE",
  //       "role": role,
  //       "fcmToken": fcmToken ?? '',
  //     };
  //     log("Fcm for google signup : $fcmToken");
  //     final response = await NetworkCaller().postRequest(
  //       AppUrls.signUp,
  //       body: body,
  //     );
  //     if (Get.isDialogOpen ?? false) {
  //       Get.back();
  //     }
  //     if (response.isSuccess) {
  //       final data = response.responseData;
  //       AppSnackBar.showSuccess("Google singup suessfull!");
  //       final token = data['data']['accessToken'];
  //       log(token);
  //       await AuthService.saveToken(token: token);
  //       Get.to(() => NavBarScreen());
  //     } else if (response.statusCode == 400) {
  //       AppSnackBar.showError("User already exists");
  //     } else {
  //       AppSnackBar.showError("Error : ${response.errorMessage}");
  //       AppLoggerHelper.error("Error : ${response.errorMessage}");
  //     }
  //   } catch (e) {
  //     AppSnackBar.showError("Api Error : $e");
  //     AppLoggerHelper.error("Api Error : $e");
  //   }
  // }
}
