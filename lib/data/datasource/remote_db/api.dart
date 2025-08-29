import 'package:dio/dio.dart';
import 'package:fampay/core/utils/app_urls.dart';

import '../../models/famx_page.dart';

class Api{
  final Dio _dio = Dio();

  Future<List<FamxPayPage>> fetchCards() async {
    try {
      final response = await _dio.get(
        AppUrls.apiUrl,
        queryParameters: {
          'slugs': 'famx-paypage'
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => FamxPayPage.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load home section');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception('Bad response: ${e.response?.statusCode}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
