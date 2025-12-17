import 'package:weathergeh_app/core/config/env.dart';

class ApiConstants {
  ApiConstants._();

  static String get apiKey => Env.openWeatherApiKey;

  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String geoUrl = 'https://api.openweathermap.org/geo/1.0';
  static const String iconUrl = 'https://openweathermap.org/img/wn';

  static const String currentWeather = '/weather';
  static const String forecast = '/forecast';
  static const String directGeo = '/direct';

  static const String iconSmall = '';
  static const String iconLarge = '@2x';
  static const String iconXLarge = '@4x';

  static String getIconUrl(String iconCode, {String size = iconLarge}) {
    return '$iconUrl/$iconCode$size.png';
  }

  static const String unitsMetric = 'metric';
  static const String unitsImperial = 'imperial';
}
