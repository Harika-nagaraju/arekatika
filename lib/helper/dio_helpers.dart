// lib/helper/dio_helpers.dart
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioHelper {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://apocatastatic-leisa-nonmonistic.ngrok-free.dev/",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET, POST, OPTIONS, PUT, DELETE, HEAD",
        "Access-Control-Allow-Headers": "Origin, Content-Type, X-Auth-Token",
      },
      responseType: ResponseType.json,
    ),
  )..interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (kDebugMode) {
          print('🌐 Sending request to ${options.path}');
          print('📦 Request data: ${options.data}');
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (kDebugMode) {
          print('✅ Response from ${response.requestOptions.path}');
          print('📦 Response data: ${response.data}');
        }
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        if (kDebugMode) {
          print('❌ Error: ${e.message}');
          print('❌ Error response: ${e.response?.data}');
        }
        return handler.next(e);
      },
    ));

  // Add this method back
  static void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
    if (kDebugMode) {
      print('🔑 Token set in headers: ${_dio.options.headers}');
    }
  }

  // Add this getter for the Dio instance
  static Dio get dio => _dio;

  static Future<Response> postData({
    required String endpoint,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        endpoint,
        data: body,
        options: Options(
          responseType: ResponseType.json,
          followRedirects: false,
          validateStatus: (status) => status! < 500,
          headers: {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
            "Access-Control-Allow-Headers": "Origin, Content-Type, X-Auth-Token",
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }
}