// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'package:app/src/core/network/failure.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

enum ApiStatus {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
  UN_PROCESSABLE_DATA,
  NOT_IMPLEMENTED,
  BAD_GATEWAY,
  SERVICE_UNAVAILABLE,
}

extension ErrorMapperExtension on ApiStatus {
  Failure getFailure({String? apiMessage}) {
    switch (this) {
      case ApiStatus.BAD_REQUEST:
        return const Failure(
          code: ResponseCode.BAD_REQUEST,
          message: ResponseMessage.BAD_REQUEST,
        );

      case ApiStatus.FORBIDDEN:
        return const Failure(
          code: ResponseCode.FORBIDDEN,
          message: ResponseMessage.FORBIDDEN,
        );

      case ApiStatus.UNAUTHORISED:
        return const Failure(
          code: ResponseCode.UNAUTHORISED,
          message: ResponseMessage.UNAUTHORISED,
        );

      case ApiStatus.NOT_FOUND:
        return const Failure(
          code: ResponseCode.NOT_FOUND,
          message: ResponseMessage.NOT_FOUND,
        );

      case ApiStatus.INTERNAL_SERVER_ERROR:
        return const Failure(
          code: ResponseCode.INTERNAL_SERVER_ERROR,
          message: ResponseMessage.INTERNAL_SERVER_ERROR,
        );

      case ApiStatus.CONNECT_TIMEOUT:
        return const Failure(
          code: ResponseCode.CONNECT_TIMEOUT,
          message: ResponseMessage.CONNECT_TIMEOUT,
        );

      case ApiStatus.CANCEL:
        return const Failure(
          code: ResponseCode.CANCEL,
          message: ResponseMessage.CANCEL,
        );

      case ApiStatus.RECEIVE_TIMEOUT:
        return const Failure(
          code: ResponseCode.RECEIVE_TIMEOUT,
          message: ResponseMessage.RECEIVE_TIMEOUT,
        );

      case ApiStatus.SEND_TIMEOUT:
        return const Failure(
          code: ResponseCode.SEND_TIMEOUT,
          message: ResponseMessage.SEND_TIMEOUT,
        );

      case ApiStatus.CACHE_ERROR:
        return const Failure(
          code: ResponseCode.CACHE_ERROR,
          message: ResponseMessage.CACHE_ERROR,
        );

      case ApiStatus.NO_INTERNET_CONNECTION:
        return const Failure(
          code: ResponseCode.NO_INTERNET_CONNECTION,
          message: ResponseMessage.NO_INTERNET_CONNECTION,
        );

      case ApiStatus.UN_PROCESSABLE_DATA:
        return const Failure(
          code: ResponseCode.UN_PROCESSABLE_DATA,
          message: ResponseMessage.UN_PROCESSABLE_DATA,
        );

      case ApiStatus.NOT_IMPLEMENTED:
        return const Failure(
          code: ResponseCode.NOT_IMPLEMENTED,
          message: ResponseMessage.NOT_IMPLEMENTED,
        );

      case ApiStatus.SERVICE_UNAVAILABLE:
        return const Failure(
          code: ResponseCode.SERVICE_UNAVAILABLE,
          message: ResponseMessage.SERVICE_UNAVAILABLE,
        );

      case ApiStatus.BAD_GATEWAY:
        return const Failure(
          code: ResponseCode.BAD_GATEWAY,
          message: ResponseMessage.BAD_GATEWAY,
        );

      case ApiStatus.DEFAULT:
        return const Failure(
          code: ResponseCode.DEFAULT,
          message: ResponseMessage.DEFAULT,
        );

      default:
        return const Failure(
          code: ResponseCode.DEFAULT,
          message: ResponseMessage.DEFAULT,
        );
    }
  }
}

class ResponseCode {
  // API status codes
  static const int SUCCESS = 200;
  static const int NO_CONTENT = 201;
  static const int BAD_REQUEST = 400;
  static const int FORBIDDEN = 403;
  static const int UNAUTHORISED = 401;
  static const int NOT_FOUND = 404;
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int NOT_IMPLEMENTED = 501;
  static const int BAD_GATEWAY = 502;
  static const int SERVICE_UNAVAILABLE = 503;
  static const int UN_PROCESSABLE_DATA = 422;
  static const int CONNECT_TIMEOUT = 408;

  // local status code
  static const int DEFAULT = -1;

  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponseMessage {
  // API status codes
  // API response codes
  static const String SUCCESS = 'success with data';
  static const String NO_CONTENT = 'success with no content';
  static const String BAD_REQUEST = 'api rejected our request';
  static const String FORBIDDEN = 'api rejected our request';
  static const String UNAUTHORISED = 'user is not authorised';
  static const String NOT_FOUND =
      'failure, API url is not correct and not found in api side.';
  static const String INTERNAL_SERVER_ERROR =
      'failure, a crash happened in API side.';
  // local responses codes
  static const String DEFAULT = 'Something went wrong';
  static const String CONNECT_TIMEOUT = 'issue in connectivity';
  static const String CANCEL = 'API request was cancelled';
  static const String RECEIVE_TIMEOUT = 'issue in connectivity';
  static const String SEND_TIMEOUT = 'issue in connectivity';
  static const String CACHE_ERROR =
      'issue in getting data from local data source (cache)';
  static const String NO_INTERNET_CONNECTION = 'No Internet Connection';
  static const String SERVICE_UNAVAILABLE = 'service unavailable';
  static const String NOT_IMPLEMENTED = 'not implemented';
  static const String BAD_GATEWAY = 'bad gateway';
  static const String UN_PROCESSABLE_DATA = 'Unprocessable Content';
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}

///
/// Exception handling fot [http] requests
///

handleResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
    case 201:
      return json.decode(response.body);

    case 400:
      if (kDebugMode) {
        log('400 - Not found');
      }

      return ApiStatus.BAD_REQUEST.getFailure();

    case 401:
      if (kDebugMode) {
        log('401 - Unauthorized.');
      }

      return ApiStatus.UNAUTHORISED.getFailure();

    case 403:
      if (kDebugMode) {
        log('403 - Not found');
      }

      return ApiStatus.FORBIDDEN.getFailure();

    case 404:
      if (kDebugMode) {
        log('404 - Not found');
      }

      return ApiStatus.NOT_FOUND.getFailure();

    case 408:
      if (kDebugMode) {
        log('408 - Connection timeout.');
      }

      return ApiStatus.CONNECT_TIMEOUT.getFailure();

    case 422:
      if (kDebugMode) {
        log('422 - Unprocessable data');
      }

      return ApiStatus.UN_PROCESSABLE_DATA.getFailure();

    case 500:
      if (kDebugMode) {
        log('500 - Internal Server Error.');
      }

      return ApiStatus.INTERNAL_SERVER_ERROR.getFailure();

    case 501:
      if (kDebugMode) {
        log('501 - Not Implemented Server Error.');
      }

      return ApiStatus.NOT_IMPLEMENTED.getFailure();

    case 502:
      if (kDebugMode) {
        log('502 - Bad Gateway Server Error.');
      }

      return ApiStatus.BAD_GATEWAY.getFailure();

    case 503:
      if (kDebugMode) {
        log('503 -Service Unavailable.');
      }

      return ApiStatus.SERVICE_UNAVAILABLE.getFailure();

    default:
      return ApiStatus.DEFAULT.getFailure();
  }
}
