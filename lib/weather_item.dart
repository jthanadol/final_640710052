import 'condition.dart';

class WeatherItem {
  String city;
  String country;
  String lastUpdated;
  double tempC;
  double tempF;
  double feelsLikeC;
  double feelsLikeF;
  double windKph;
  double windMph;
  double humidity;
  int uv;
  Condition condition;

  WeatherItem({
    required this.city,
    required this.country,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.feelsLikeC,
    required this.feelsLikeF,
    required this.windKph,
    required this.windMph,
    required this.humidity,
    required this.uv,
    required this.condition,
  });

  factory WeatherItem.fromJson(Map<String, dynamic> json) {
    return WeatherItem(
      city: json['city'],
      country: json['country'],
      lastUpdated: json['lastUpdated'],
      tempC: json['tempC'],
      tempF: json['tempF'],
      feelsLikeC: json['feelsLikeC'],
      feelsLikeF: json['feelsLikeF'],
      windKph: json['windKph'],
      windMph: json['windMph'],
      humidity: json['humidity'],
      uv: json['uv'],
      condition: Condition.fromJson(json['condition']),
    );
  }
}
