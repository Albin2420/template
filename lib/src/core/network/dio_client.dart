import 'dart:developer';
import 'package:app/src/core/url.dart';
import 'package:app/src/data/services/token/token_services.dart';
import 'package:dio/dio.dart';

class DioClient {
  static final Dio dio =
      Dio()
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              final token = await StorageService.getAccessToken();

              if (token == null) {
                options.headers['Authorization'] = 'Bearer $token';
              }
              options.headers['Content-Type'] = 'application/json';
              log("🌍 API -> ${options.method} URL: ${options.uri}");

              return handler.next(options);
            },

            onError: (DioException error, handler) async {
              log("❌ API Error Status: ${error.response?.statusCode}");

              if (error.response?.statusCode == 403) {
                log("🔴 Token expired — Attempting refresh...");

                final refreshed = await _handleTokenRefresh();

                if (refreshed) {
                  final RequestOptions requestOptions = error.requestOptions;
                  final response = await dio.fetch(requestOptions);

                  return handler.resolve(response);
                } else {
                  log("🚪 Refresh failed → Logout user");

                  return handler.next(error);
                }
              }

              return handler.next(error);
            },

            onResponse: (response, handler) {
              log("✅ API Response: ${response.statusCode}");
              return handler.next(response);
            },
          ),
        );

  static Future<bool> _handleTokenRefresh() async {
    try {
      final refreshToken = await StorageService.getRefreshToken();

      if (refreshToken == null) {
        log("⚠ No refresh token available");
        return false;
      }

      log("🔄 Calling Refresh Token API...");

      final response = await dio.post(
        "${Url.baseUrl}/${Url.refresh}",
        data: {"refresh": refreshToken},
      );

      if (response.statusCode == 200) {
        final newAccess = response.data["access"] ?? "";

        if (newAccess.isNotEmpty) {
          await StorageService.saveTokens(accessToken: newAccess);
          log("✔ Token Refresh Success");
          return true;
        }
      } else {
        log("❌ Refresh API failed");
        return false;
      }
      return false;
    } catch (e) {
      log("💥 Refresh Token Exception: $e");
      return false;
    }
  }
}
