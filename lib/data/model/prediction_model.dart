class PredictionModel {
  final String cityName;
  final List<DailyPredict> dailyForecasts;

  PredictionModel({
    required this.cityName,
    required this.dailyForecasts,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    final list = json['list'] as List;
    final cityName = json['city']['name'] as String;

    final Map<String, List<dynamic>> groupedByDay = {};

    for (var item in list) {
      final dateTime = DateTime.parse(item['dt_txt']);
      final dateKey = '${dateTime.year}-${dateTime.month}-${dateTime.day}';

      if (!groupedByDay.containsKey(dateKey)) {
        groupedByDay[dateKey] = [];
      }
      groupedByDay[dateKey]!.add(item);
    }

    final dailyForecasts = <DailyPredict>[];

    for (var dayData in groupedByDay.values) {
      var midDayData = dayData.firstWhere(
            (item) => item['dt_txt'].contains('12:00:00'),
        orElse: () => dayData[dayData.length ~/ 2],
      );

      dailyForecasts.add(DailyPredict.fromJson(midDayData));
    }

    return PredictionModel(
      cityName: cityName,
      dailyForecasts: dailyForecasts.take(4).toList(),
    );
  }
}

class DailyPredict {
  final DateTime date;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;
  final double windSpeed;
  final int humidity;

  DailyPredict({
    required this.date,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.windSpeed,
    required this.humidity,
  });

  factory DailyPredict.fromJson(Map<String, dynamic> json) {
    return DailyPredict(
      date: DateTime.parse(json['dt_txt']),
      temp: (json['main']['temp'] as num).toDouble(),
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      weatherMain: json['weather'][0]['main'],
      weatherDescription: json['weather'][0]['description'],
      weatherIcon: json['weather'][0]['icon'],
      windSpeed:json['wind']['speed'] ,
      humidity: json['main']['humidity'],
    );
  }

  String get weekDay {
    const days = ['Dush', 'Sesh', 'Chor', 'Pay', 'Jum', 'Shan', 'Yak'];
    return days[date.weekday - 1];
  }

  String get dayMonth {
    return '${date.day}';
  }
}
