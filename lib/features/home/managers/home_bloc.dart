import 'package:bloc/bloc.dart';
import 'package:weathermap_project/features/home/managers/home_event.dart';
import 'package:weathermap_project/features/home/managers/home_state.dart';
import '../../../data/repository/image_repository.dart';
import '../../../data/repository/weather_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WeatherRepository weatherRepo;
  final CityImageRepository imageRepo;

  HomeBloc(this.weatherRepo, this.imageRepo)
      : super(HomeState.initial()) {
    on<LoadEvent>(_load);
  }

  Future<void> _load(
      LoadEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(
      state.copyWith(
        loading: true,
        error: null,
        weather: null,
        cityImageUrl: null,
        predictionModel: null,
      ),
    );

    // 1️⃣ Weather API
    final weatherResult = await weatherRepo.getWeather(event.city);

    await weatherResult.fold(
          (error) async {
        emit(state.copyWith(
          loading: false,
          error: error.toString(),
        ));
      },
          (weather) async {
        // 2️⃣ Image API
        final imgResult = await imageRepo.getCityImage(event.city);

        String? cityImageUrl;
        imgResult.fold(
              (imgError) {
            emit(state.copyWith(
              loading: false,
              weather: weather,
              error: imgError.toString(),
            ));
          },
              (imgUrl) {
            cityImageUrl = imgUrl;
          },
        );


        final predictionResult = await weatherRepo.getPrediction(event.city);
        predictionResult.fold(
              (predictionError) {
            emit(state.copyWith(
              loading: false,
              weather: weather,
              cityImageUrl: cityImageUrl,
              error: predictionError.toString(),
            ));
          },
              (predictionModel) {
            emit(state.copyWith(
              loading: false,
              weather: weather,
              cityImageUrl: cityImageUrl,
              predictionModel: predictionModel,
            ));
          },
        );
      },
    );
  }

}