import 'package:http/http.dart' as http;

class ApiService {
  static final ApiService _singleton = ApiService._internal();
  factory ApiService() => _singleton;
  ApiService._internal();

  /// Get Request
  Future get({required String url, Map<String, String>? headers}) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get Request
  Future post({
    required String url,
    required Object data,
    bool? isSecureApi,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}



// services/
// ├── api_service.dart
// ├── auth_service.dart
// ├── notification_service.dart
// ├── secure_storage_service.dart
// ├── analytics_service.dart
// ├── data_access/
// │   ├── hive_service.dart
// │   ├── sqlite_service.dart
// ├── utils/
// │   ├── network_service.dart
// │   ├── file_service.dart'




// class UserRepository {
//   final ApiService _apiService = Get.find<ApiService>();
//   final LocalStorageService _localStorageService = Get.find<LocalStorageService>();
//   final ConnectivityService _connectivityService = Get.find<ConnectivityService>();

//   Future<List<User>> fetchUsers() async {
//     try {
//       // Check network status
//       final isConnected = await _connectivityService.isConnected();

//       if (isConnected) {
//         // Fetch from API if online
//         final apiUsers = await _apiService.fetchUsers();
//         // Save to local storage for offline use
//         await _localStorageService.saveUsers(apiUsers);
//         return apiUsers;
//       } else {
//         // Fetch from local storage if offline
//         final cachedUsers = await _localStorageService.getUsers();
//         if (cachedUsers.isNotEmpty) {
//           return cachedUsers;
//         } else {
//           throw Exception('No internet connection and no cached data available.');
//         }
//       }
//     } catch (e) {
//       throw Exception('Error fetching users: $e');
//     }
//   }
// }
