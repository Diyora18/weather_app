import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weathermap_project/data/model/prediction_model.dart';
import 'package:weathermap_project/data/model/weather_model.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    String? cityImageUrl,
    String? error,
    @Default(false) bool loading,
    WeatherModel? weather,
    @Default([]) List<WeatherModel> savedLocations,
    PredictionModel? predictionModel,
  }) = _HomeState;

  factory HomeState.initial() => const HomeState(
    cityImageUrl: null,
    error: null,
    loading: false,
    weather: null,
    savedLocations: [],
    predictionModel: null,
  );
}
