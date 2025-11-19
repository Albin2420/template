// implentation of the repositories


// import 'dart:developer';
//
// import '../../core/network/failure.dart';
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
//
// import '../../core/url.dart';
//
// class abstractClassimpl extends abstractclass {
//   final Dio _dio = Dio();
//
//   @override
//   Future<Either<Failure, Map<String, dynamic>>> funt({}) async {
//     final url = '${Url.baseUrl}/blood-request/$id/accept';
//     log(" 🔌 POST : $url");
//
//     try {
//       final response = await _dio.post(
//         url,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': 'Bearer $accesstoken',
//           },
//         ),
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         log(
//           "✅ Response Status of /${Url.baseUrl}/blood-request/$id/accept: ${response.statusCode}",
//         );
//
//         return right({});
//       } else {
//         log(
//           "❌ Response Status of /${Url.baseUrl}/blood-request/$id/accept: ${response.statusCode}",
//         );
//         return left(Failure(message: 'Server error: ${response.statusCode}'));
//       }
//     } on DioException catch (e) {
//       log("❌ Dio error in acceptReq: ${e.message}");
//       if (e.response != null) {
//         log("Dio error response: ${e.response?.data['detail']}");
//         return left(Failure(message: '${e.response?.data['detail']}'));
//       }
//       return left(Failure(message: 'Network error: ${e.message}'));
//     } catch (e) {
//       log("💥 Unexpected error: $e");
//       return left(Failure(message: 'Unexpected error occurred'));
//     }
//   }
// }











// import 'dart:async';
// import 'dart:developer';
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:get/get.dart' hide Response;

// import '../../controllers/app_startup_controller.dart';
// import '../../utils/failure.dart';
// import '../../utils/url.dart';

// class HomApi {
//   final Dio _dio = Dio(BaseOptions(baseUrl: Url.baseurl));
//   final ctr = Get.find<AppstartupController>();

//   bool _isRefreshing = false;
//   final List<Completer<Response>> _pendingRequests = [];

//   HomApi() {
//     _dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) {
//           options.headers["Authorization"] = "Bearer ${ctr.accessToken.value}";
//           log("➡️ REQUEST → ${options.method} ${options.uri}");
//           return handler.next(options);
//         },

//         onResponse: (response, handler) {
//           log("⬅️ RESPONSE → ${response.statusCode}");
//           return handler.next(response);
//         },

//         onError: (error, handler) async {
//           log("❌ ERROR → ${error.response?.statusCode}");

//           if (error.response?.statusCode == 401 && !_isRefreshing) {
//             _isRefreshing = true;

//             final completer = Completer<Response>();
//             _pendingRequests.add(completer);

//             final ok = await _refreshToken();
//             _isRefreshing = false;

//             if (ok) {
//               log("🔄 Refresh done, retrying pending…");

//               for (final c in _pendingRequests) {
//                 await _retryRequest(c, error.requestOptions);
//               }

//               _pendingRequests.clear();

//               return handler.resolve(await completer.future);
//             } else {
//               log("❌ Refresh failed → logout");
//               for (final c in _pendingRequests) {
//                 c.completeError(
//                   DioException(requestOptions: error.requestOptions),
//                 );
//               }
//               _pendingRequests.clear();
//               return handler.reject(error);
//             }
//           } else {
//             return handler.reject(error);
//           }
//         },
//       ),
//     );
//   }

//   Future<void> _retryRequest(
//     Completer<Response> completer,
//     RequestOptions requestOptions,
//   ) async {
//     try {
//       final response = await _dio.request(
//         requestOptions.path,
//         data: requestOptions.data,
//         queryParameters: requestOptions.queryParameters,
//         options: Options(
//           method: requestOptions.method,
//           headers: {
//             ...requestOptions.headers,
//             "Authorization": "Bearer ${ctr.accessToken.value}",
//           },
//         ),
//       );

//       completer.complete(response);
//     } catch (e) {
//       completer.completeError(e);
//     }
//   }

//   Future<bool> _refreshToken() async {
//     try {
//       final res = await _dio.post(
//         Url.refreshToken,
//         data: {"refresh": ctr.refreshToken.value},
//       );

//       if (res.statusCode == 200) {
//         await ctr.saveTokens(accessTokEn: res.data["access"]);
//         if (res.data["refresh"] != null) {
//           await ctr.saveTokens(refreshTokEn: res.data["refresh"]);
//         }
//         return true;
//       }
//       return false;
//     } catch (e) {
//       log("❌ Refresh Error: $e");
//       return false;
//     }
//   }

//   Future<Either<Failure, Map<String, dynamic>>> fetchHomeData() async {
//     try {
//       final response = await _dio.get(Url.user);

//       if (response.statusCode == 200) {
//         return Right({});
//       } else {
//         return Left(Failure());
//       }
//     } on DioException catch (e) {
//       log("❌ DioException: ${e.message}");
//       return Left(Failure());
//     } catch (e) {
//       log("❌ Unknown Exception: $e");
//       return Left(Failure());
//     }
//   }
// }
