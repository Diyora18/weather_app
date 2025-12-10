class WeatherModel {
  final String city;
  final String country;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  final int clouds;
  final String mainDescription;
  final String description;
  final String icon;

  WeatherModel({
    required this.city,
    required this.country,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.clouds,
    required this.mainDescription,
    required this.description,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'] as String,
      country: json['sys']['country'] as String,
      temp: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      pressure: json['main']['pressure'] as int,
      humidity: json['main']['humidity'] as int,
      visibility: json['visibility'] as int,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      windDeg: json['wind']['deg'] as int,
      clouds: json['clouds']['all'] as int,
      mainDescription: json['weather'][0]['main'] as String,
      description: json['weather'][0]['description'] as String,
      icon: json['weather'][0]['icon'] as String,
    );
  }

  WeatherModel copyWith({
    String? photoUrl,
  }) {
    return WeatherModel(
      city: city,
      country: country,
      temp: temp,
      feelsLike: feelsLike,
      tempMin: tempMin,
      tempMax: tempMax,
      pressure: pressure,
      humidity: humidity,
      visibility: visibility,
      windSpeed: windSpeed,
      windDeg: windDeg,
      clouds: clouds,
      mainDescription: mainDescription,
      description: description,
      icon: icon,
    );
  }
}
