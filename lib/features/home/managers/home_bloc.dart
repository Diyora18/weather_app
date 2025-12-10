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
    emit(state.copyWith(loading: true, error: null));

    try {
      // 1️⃣ Weather
      final weather = await weatherRepo.getWeather(event.city).then(
            (res) => res.fold((l) => throw l, (r) => r),
      );

      // Weather darhol qo‘shiladi
      emit(state.copyWith(
        savedLocations: List.from(state.savedLocations)..add(weather),
      ));

      // 2️⃣ Image
      final cityImageUrl = await imageRepo.getCityImage(event.city)
          .then((res) => res.fold((_) => null, (r) => r));

      // 3️⃣ Prediction
      final predictionModel = await weatherRepo.getPrediction(event.city)
          .then((res) => res.fold((_) => null, (r) => r));

      emit(state.copyWith(
        cityImageUrl: cityImageUrl,
        predictionModel: predictionModel,
        loading: false,
      ));

    } catch (e) {
      emit(state.copyWith(
        loading: false,
        error: e.toString(),
      ));
    }
  }
}