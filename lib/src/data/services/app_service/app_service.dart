// import 'dart:developer';
// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:flutter/foundation.dart';
// import 'package:neuflo_learn/src/core/network/error_handler.dart';
// import 'package:neuflo_learn/src/core/network/failure.dart';
// import 'package:neuflo_learn/src/core/url.dart';
// import 'package:neuflo_learn/src/data/services/data_access/api_service.dart';

// class AppStatusService {
//   ApiService apiService = ApiService();
//   Future<Either<Failure, bool>> getStatus() async {
//     if (kDebugMode) {
//       log('${Url.baseUrl1}/${Url.status}');
//     }
//     try {
//       final response = await apiService.get(
//         url: '${Url.baseUrl1}/${Url.status}',
//       );
//       dynamic result = handleResponse(response);

//       log("result =>: $result");

//       return Right(result["enabled"]);
//     } on FormatException catch (e) {
//       debugPrint('exception : $e');
//       return const Left(
//         Failure(message: 'Format Exception'),
//       );
//     } on SocketException catch (e) {
//       debugPrint('exception : $e');
//       return const Left(
//         Failure(
//           code: ResponseCode.NO_INTERNET_CONNECTION,
//           message: ResponseMessage.NO_INTERNET_CONNECTION,
//         ),
//       );
//     } on Exception catch (e) {
//       debugPrint('exception : $e');
//       return const Left(
//         Failure(message: 'Unknown error, Try again later'),
//       );
//     }
//     // return Right(true);
//   }
// }
