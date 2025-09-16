// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class SecureStorageService {
//   SecureStorageService._();
//   static final SecureStorageService instance = SecureStorageService._();
//   factory SecureStorageService() => instance;

//   final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

//   // iOS options
//   final IOSOptions _iosOptions = IOSOptions(
//     accessibility: KeychainAccessibility.first_unlock,
//   );

//   // Android options
//   final AndroidOptions _androidOptions = AndroidOptions(
//     encryptedSharedPreferences: true,
//   );

//   // Write a value
//   Future<void> write(String key, String value) async {
//     await _secureStorage.write(
//       key: key,
//       value: value,
//       iOptions: _iosOptions,
//       aOptions: _androidOptions,
//     );
//   }

//   // Read a value
//   Future<String?> read(String key) async {
//     return await _secureStorage.read(
//       key: key,
//       iOptions: _iosOptions,
//       aOptions: _androidOptions,
//     );
//   }

//   // Delete a value
//   Future<void> delete(String key) async {
//     await _secureStorage.delete(
//       key: key,
//       iOptions: _iosOptions,
//       aOptions: _androidOptions,
//     );
//   }

//   // Check if a key exists
//   Future<bool> containsKey(String key) async {
//     return await _secureStorage.containsKey(
//       key: key,
//       iOptions: _iosOptions,
//       aOptions: _androidOptions,
//     );
//   }

//   // Read all values
//   Future<Map<String, String>> readAll() async {
//     return await _secureStorage.readAll(
//       iOptions: _iosOptions,
//       aOptions: _androidOptions,
//     );
//   }

//   // Delete all values
//   Future<void> deleteAll() async {
//     await _secureStorage.deleteAll(
//       iOptions: _iosOptions,
//       aOptions: _androidOptions,
//     );
//   }
// }
