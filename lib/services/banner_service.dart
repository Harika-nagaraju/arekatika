// lib/services/banner_service.dart
import 'package:dio/dio.dart';
import 'package:arekatika/helper/dio_helpers.dart';

class BannerService {
  static Future<Map<String, dynamic>> getBanners() async {
    try {
      final response = await DioHelper.dio.get(
        '/users/banners',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data,
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to load banners',
          'error': response.data['message'] ?? 'Unknown error occurred',
        };
      }
    } on DioException catch (e) {
      return {
        'success': false,
        'message': 'Network error occurred',
        'error': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred',
        'error': e.toString(),
      };
    }
  }
}