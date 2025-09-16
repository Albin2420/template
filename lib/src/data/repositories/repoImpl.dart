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
