import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pokedex/constants/api_constants.dart';

class ApiService extends GetxService {
  late Dio _dio;

  @override
  void onInit() {
    super.onInit();
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint("Request: ${options.method} ${options.path}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint("Response: ${response.statusCode} ${response.data}");
          return handler.next(response);
        },
        onError: (error, handler) {
          debugPrint("Error: ${error.response?.statusCode} ${error.message}");
          return handler.next(error);
        },
      ),
    );
  }

  Future<dynamic> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.get(endpoint, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> post(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  dynamic _handleError(DioError error) {
    String errorMessage;

    if (error.response != null) {
      switch (error.response?.statusCode) {
        case 400:
          errorMessage =
              "Bad Request: ${error.response?.data['message'] ?? 'Invalid data provided'}";
          break;
        case 401:
          errorMessage = "Unauthorized: Please check your credentials.";
          break;
        case 403:
          errorMessage =
              "Forbidden: You don't have permission to access this resource.";
          break;
        case 404:
          errorMessage =
              "Not Found: The requested resource could not be found.";
          break;
        case 500:
        default:
          errorMessage = "Server Error: Please try again later.";
      }
    } else {
      errorMessage = "Network Error: Please check your internet connection.";
    }
    debugPrint("API Error: $errorMessage");
    return {"error": true, "message": errorMessage};
  }
}
