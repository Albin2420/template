import 'package:app/src/core/network/error_handler.dart';

class Failure implements Exception {
  const Failure({required this.message, this.code});
  final String message;
  final int? code;

  Failure copyWith({String? message}) =>
      Failure(message: message ?? this.message);

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}

class DefaultFailure extends Failure {
  DefaultFailure()
    : super(code: ResponseCode.DEFAULT, message: ResponseMessage.DEFAULT);
}
