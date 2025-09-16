// import 'dart:developer' as log;
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:neuflo_learn/src/core/util/constants/firebase_error.dart';

// enum AuthStatus {
//   ///android
//   successful,
//   emailAlreadyExists,

//   accountAlreayExists,

//   credentialAlreadyInUse,
//   wrongPassword,
//   invalidEmail,
//   invalidCredential,
//   invalidVerificationCode,
//   providerAlreadyLinked,
//   userNotFound,
//   userDisabled,
//   operationNotAllowed,
//   tooManyRequests,
//   networkRequestFailed,
//   undefined,

//   ///apple
//   /// The user canceled the authorization attempt.
//   canceled,

//   /// The authorization attempt failed.
//   failed,

//   /// The authorization request received an invalid response.
//   invalidResponse,

//   /// The authorization request wasn’t handled.
//   notHandled,

//   /// The authorization request isn’t interactive.
//   notInteractive,

//   /// The authorization attempt failed for an unknown reason.
//   unknown,
// }

// class FirebaseAuthService extends Auth {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   /// to subscribe auth state
//   @override
//   Stream<User?> get onAuthStateChanged {
//     return _firebaseAuth.authStateChanges();
//   }

//   /// to subscribe user changes
//   @override
//   Stream<User?> get onUserChanges => _firebaseAuth.userChanges();

//   @override
//   Future<AuthStatus?> signInWithGoogle() async {
//     AuthStatus? status;

//     // Trigger the authentication flow
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//     try {
//       if (googleUser != null) {
//         // Obtain the auth details from the request
//         final GoogleSignInAuthentication googleAuth =
//             await googleUser.authentication;

//         final UserCredential userCredential = await _firebaseAuth
//             .signInWithCredential(GoogleAuthProvider.credential(
//           idToken: googleAuth.idToken,
//           accessToken: googleAuth.accessToken,
//         ));
//         if (userCredential.user != null) {
//           status = AuthStatus.successful;
//         } else {
//           status = AuthStatus.undefined;
//         }
//       }
//     } catch (e) {
//       status = AuthExceptionHandler.handleException(e);
//     }

//     return status;
//   }

//   @override
//   Future<void> signOut() async {
//     final GoogleSignIn googleSignIn = GoogleSignIn();
//     await _firebaseAuth.signOut();
//     await googleSignIn.signOut();
//   }

//   /// To refresh firebase token
//   @override
//   Future<void> refreshFirebaseToken() async {
//     final User? user = _firebaseAuth.currentUser;
//     final String? idToken = await user?.getIdToken(true);
//     if (kDebugMode) {
//       log.log("current user token = $idToken");
//     }
//   }

//   @override
//   Future<void> googleSignOut() async {
//     final GoogleSignIn googleSignIn = GoogleSignIn();
//     await googleSignIn.signOut();
//   }

//   @override
//   User? getCurrentUser() {
//     return _firebaseAuth.currentUser;
//   }

//   @override
//   Future refreshUser() {
//     // TODO: implement refreshUser
//     throw UnimplementedError();
//   }

//   @override
//   Future updateUserPhoneNumber() async {
//     final User? user = _firebaseAuth.currentUser;
//     if (user != null) {}
//   }
// }

// // ignore: avoid_classes_with_only_static_members
// class AuthExceptionHandler {
//   static dynamic handleException(e) {
//     AuthStatus status;
//     switch (e.code) {
//       case "email-already-in-use":
//         status = AuthStatus.emailAlreadyExists;
//         break;
//       case "account-exists-with-different-credential":
//         status = AuthStatus.accountAlreayExists;
//         break;
//       case "credential-already-in-use":
//         status = AuthStatus.credentialAlreadyInUse;
//         break;
//       case "wrong-password":
//         status = AuthStatus.wrongPassword;
//         break;
//       case "error-invalid-email":
//         status = AuthStatus.invalidEmail;
//         break;
//       case "invalid-credential":
//         status = AuthStatus.invalidCredential;
//         break;
//       case "invalid-verification-code":
//         status = AuthStatus.invalidVerificationCode;
//         break;
//       case "provider-already-linked":
//         status = AuthStatus.providerAlreadyLinked;
//         break;
//       case "user-not-found":
//         status = AuthStatus.userNotFound;
//         break;
//       case "user-disabled":
//         status = AuthStatus.userDisabled;
//         break;
//       case "operation-not-allowed":
//         status = AuthStatus.operationNotAllowed;
//         break;
//       case "too-many-requests":
//         status = AuthStatus.tooManyRequests;
//         break;
//       case "network-request-failed":
//         status = AuthStatus.networkRequestFailed;
//         break;

//       default:
//         status = AuthStatus.undefined;
//     }
//     return status;
//   }

//   ///
//   /// Accepts AuthExceptionHandler.errorType
//   ///
//   static String generateExceptionMessage(dynamic exceptionCode) {
//     String errorMessage;
//     switch (exceptionCode) {
//       case AuthStatus.emailAlreadyExists:
//         errorMessage = kEmailAlreadyExists;
//         // "The email has already been registered. Please login or reset your password.";
//         break;
//       case AuthStatus.accountAlreayExists:
//         errorMessage = kAccountAlreayExists;
//         // "Account exists with different credential";
//         break;
//       case AuthStatus.credentialAlreadyInUse:
//         errorMessage = kCredentialAlreadyInUse;
//         // "This credential is already associated with a different user account.";
//         break;
//       case AuthStatus.wrongPassword:
//         errorMessage = kWrongPassword;
//         // "Password entered is wrong.";
//         break;
//       case AuthStatus.invalidEmail:
//         errorMessage = kInvalidEmail;
//         // "Your email address appears to be invalid.";
//         break;
//       case AuthStatus.invalidCredential:
//         errorMessage = kInvalidCredential;
//         // "Invalid credential.";
//         break;
//       case AuthStatus.invalidVerificationCode:
//         errorMessage = kInvalidVerificationCode;
//         // "Invalid verification code.";
//         break;
//       case AuthStatus.providerAlreadyLinked:
//         errorMessage = kProviderAlreadyLinked;
//         // "Provider has already been linked to another account";
//         break;
//       case AuthStatus.userNotFound:
//         errorMessage = kUserNotFound;
//         // "There is no user record corresponding to this identifier.";
//         break;
//       case AuthStatus.userDisabled:
//         errorMessage = kUserDisabled;
//         // "User with this email has been disabled.";
//         break;
//       case AuthStatus.operationNotAllowed:
//         errorMessage = kOperationNotAllowed;
//         // "Signing in with Email and Password is not enabled.";
//         break;
//       case AuthStatus.tooManyRequests:
//         errorMessage = kTooManyRequests;
//         // "Too many requests. Try again later.";
//         break;
//       case AuthStatus.networkRequestFailed:
//         errorMessage = kNetworkRequestFailed;
//         // "Network request failed.";
//         break;

//       case AuthStatus.canceled:
//         errorMessage = kCanceled;
//         // "The user canceled the authorization attempt";
//         break;

//       case AuthStatus.failed:
//         errorMessage = kFailed;
//         // "The authorization attempt failed";
//         break;

//       case AuthStatus.invalidResponse:
//         errorMessage = kInvalidResponse;
//         // " The authorization request received an invalid response.";
//         break;
//       case AuthStatus.notHandled:
//         errorMessage = kNotHandled;
//         // "The authorization request wasn’t handled.";
//         break;
//       case AuthStatus.unknown:
//         errorMessage = kUnknown;
//         // " The authorization attempt failed for an unknown reason.";
//         break;
//       default:
//         errorMessage = kDefaultMessgae;
//         break;
//       // "An undefined Error happened.";
//     }

//     return errorMessage;
//   }
// }
