import 'package:dio/dio.dart';
import 'package:weathermap_project/core/service/result.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Future<Result<T>> get<T>(
      String url, {
        Map<String, dynamic>? queryParams,
        Map<String, dynamic>? headers,
      }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Result.ok(response.data as T);
      }

      return Result.error(Exception(response.data));
    } catch (e) {
      return Result.error(Exception(e));
    }
  }
}
