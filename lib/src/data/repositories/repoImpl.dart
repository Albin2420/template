// import 'dart:developer';
// import 'package:app/src/core/network/dio_client.dart';
// import 'package:app/src/core/network/failure.dart';
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';

// class RepoImpl extends Repo {
//   @override
//   Future<Either<Failure, Map<String, dynamic>>> func() async {
//     final url = "${Url.baseUrl}/${Url.myBooth}";

//     try {
//       final response = await DioClient.dio.get(url);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         final item = data[0];

//         return right({});
//       } else {
//         return Left(Failure(message: "${response.statusMessage}"));
//       }
//     } on DioException catch (e) {
//       log("❌ Dio error: ${e.message}");
//       return left(
//         Failure(
//           message:
//               e.response?.data?['detail']?.toString() ??
//               "Something went wrong!",
//         ),
//       );
//     } catch (e) {
//       log("💥 Unexpected error: $e");
//       return left(Failure(message: "$e"));
//     }
//   }
// }
