import 'package:dio/dio.dart';

class WeatherInterceptor extends Interceptor {
  final String apiKey;
  WeatherInterceptor(this.apiKey);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
      options.queryParameters.addAll({
      "appid": apiKey,
      "units": "metric", // harorat °C bo‘lishi uchun
    });

    print("➡ REQUEST: ${options.method} ${options.uri}");
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("⬅ RESPONSE: ${response.statusCode}");
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("❌ ERROR: ${err.response?.statusCode} - ${err.message}");
    handler.next(err);
  }
}
