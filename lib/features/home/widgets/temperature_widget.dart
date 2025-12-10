import 'package:flutter/material.dart';
import 'package:weathermap_project/data/model/weather_model.dart';
import 'package:weathermap_project/features/home/widgets/humidity_widget.dart';

class TemperatureWidget extends StatelessWidget {
  final WeatherModel weatherModel;

  const TemperatureWidget({super.key, required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          weatherModel.city,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        Text(
          weatherModel.description,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        Text(
          "${weatherModel.temp.toStringAsFixed(1)}°C",
          style: const TextStyle(
            fontSize: 76,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 42),
        HumidityWidget(weatherModel: weatherModel),
      ],
    );
  }
}
