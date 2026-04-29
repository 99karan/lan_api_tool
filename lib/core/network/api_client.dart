import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<String> send({
    required String url,
    required String method,
  }) async {
    try {
      final response = await _dio.request(
        url,
        options: Options(method: method),
      );

      return response.data.toString();
    } catch (e) {
      return "Error: $e";
    }
  }
}