import 'package:flutter/material.dart';
import '../../../data/model/weather_model.dart';

class WeatherContainer extends StatelessWidget {
  final WeatherModel weather;

  const WeatherContainer({required this.weather, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 345,
      height: 153,
      decoration: BoxDecoration(
        color: const Color(0xFFAAA5A5).withAlpha(70),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  weather.city,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  weather.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  "Humidity: ${weather.humidity}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "Wind: ${weather.windSpeed}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 71),
            child: Text(
              "${weather.temp}°C",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
