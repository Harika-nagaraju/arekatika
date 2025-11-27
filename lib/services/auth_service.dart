// lib/services/auth_service.dart
import 'package:dio/dio.dart';
import 'package:arekatika/helper/dio_helpers.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  static Future<Map<String, dynamic>> updateKyc({
    required String mobileNumber,
    required String firstName,
    required String lastName,
    required String email,
    required String gender,
    required String referral,
  }) async {
    try {
      final response = await DioHelper.dio.post(
        '/auth/update-kyc',
        data: {
          'mobileNumber': mobileNumber,
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'gender': gender,
          'reffaral': referral,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // 'Authorization': 'Bearer $token', // Uncomment if auth is required
          },
        ),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data,
          'token': response.data['token'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Failed to update KYC',
        };
      }
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data?['message'] ?? 'Network error occurred',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred',
      };
    }
  }
}