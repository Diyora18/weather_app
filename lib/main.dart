import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathermap_project/features/home/managers/home_bloc.dart';
import 'core/service/client.dart';
import 'data/repository/image_repository.dart';
import 'data/repository/weather_repository.dart';
import 'features/home/pages/page_1.dart';


void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final apiClient = ApiClient(dio);
    final weatherRepository = WeatherRepository(apiClient: apiClient);
    final cityImageRepository = CityImageRepository( apiClient);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              HomeBloc(weatherRepository, cityImageRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Weather App",
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomePage(),
      ),
    );
  }
}
