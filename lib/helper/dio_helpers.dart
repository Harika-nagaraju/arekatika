import 'package:dio/dio.dart';

class DioHelper {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://apocatastatic-leisa-nonmonistic.ngrok-free.dev/",
      connectTimeout: Duration(seconds: 15),
      receiveTimeout: Duration(seconds: 15),
      headers: {"Content-Type": "application/json"},
    ),
  );

  static void setToken(String token) {
    dio.options.headers["Authorization"] = "Bearer $token";
  }

  static void initInterceptor() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print("➡️ REQUEST: ${options.method} ${options.uri}");
          print("Headers: ${options.headers}");
          print("Data: ${options.data}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("✔️ RESPONSE: ${response.statusCode}");
          return handler.next(response);
        },
        onError: (error, handler) {
          print("❌ ERROR: $error");
          return handler.next(error);
        },
      ),
    );
  }

  // GET Request
  static Future<Response> getData({
    required String endpoint,
    Map<String, dynamic>? query,
  }) async {
    try {
      return await dio.get(endpoint, queryParameters: query);
    } catch (e) {
      throw Exception("GET ERROR: $e");
    }
  }

  // POST Request
  static Future<Response> postData({
    required String endpoint,
    Map<String, dynamic>? body,
  }) async {
    try {
      return await dio.post(endpoint, data: body);
    } catch (e) {
      throw Exception("POST ERROR: $e");
    }
  }

  // File Upload
  static Future<Response> uploadFile({
    required String endpoint,
    required String fieldName,
    required String filePath,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(filePath),
      });

      return await dio.post(endpoint, data: formData);
    } catch (e) {
      throw Exception("UPLOAD ERROR: $e");
    }
  }
}
