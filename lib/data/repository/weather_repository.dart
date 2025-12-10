import 'package:weathermap_project/data/model/prediction_model.dart';

import '../../core/service/client.dart';
import '../../core/service/result.dart';
import '../model/weather_model.dart';

class WeatherRepository {
  final ApiClient _apiClient;

  WeatherRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  Future<Result<WeatherModel>> getWeather(String cityName) async {
    final params = {
      "q": cityName,
      "appid": "37457ba57cff3a87973044a1e1e4cb9a",
      "units": "metric",
    };

    var response = await _apiClient.get<Map<String, dynamic>>(
      "https://api.openweathermap.org/data/2.5/weather",
      queryParams: params,
    );

    return response.fold(
          (error) => Result.error(error),
          (data) {
        final weather = WeatherModel.fromJson(Map<String, dynamic>.from(data));
        return Result.ok(weather);
      },
    );

  }
  Future<Result<PredictionModel>> getPrediction(String cityName) async {
    final params = {
      "q": cityName,
      "appid": "37457ba57cff3a87973044a1e1e4cb9a",
      "units": "metric",
    };

    var response = await _apiClient.get<Map<String, dynamic>>(
      "https://api.openweathermap.org/data/2.5/forecast",
      queryParams: params,
    );

    return response.fold(
          (error) => Result.error(error),
          (data) {
        final prediction = PredictionModel.fromJson(data);
        return Result.ok(prediction);
      },
    );
  }

}

