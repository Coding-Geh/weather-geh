import 'package:weathergeh_app/core/constants/api_constants.dart';
import 'package:weathergeh_app/core/utils/api_helper.dart';
import 'package:weathergeh_app/models/weather.dart';

class WeatherService {
  final _dio = ApiHelper.dio;
  final _geoDio = ApiHelper.geoDio;

  Future<CurrentWeather> getCurrentWeather(double lat, double lon) async {
    final response = await _dio.get(
      ApiConstants.currentWeather,
      queryParameters: {'lat': lat, 'lon': lon},
    );
    return CurrentWeather.fromJson(response.data);
  }

  Future<CurrentWeather> getCurrentWeatherByCity(String city) async {
    final response = await _dio.get(
      ApiConstants.currentWeather,
      queryParameters: {'q': city},
    );
    return CurrentWeather.fromJson(response.data);
  }

  Future<ForecastResponse> getForecast(double lat, double lon) async {
    final response = await _dio.get(
      ApiConstants.forecast,
      queryParameters: {'lat': lat, 'lon': lon},
    );
    return ForecastResponse.fromJson(response.data);
  }

  Future<ForecastResponse> getForecastByCity(String city) async {
    final response = await _dio.get(
      ApiConstants.forecast,
      queryParameters: {'q': city},
    );
    return ForecastResponse.fromJson(response.data);
  }

  Future<List<GeoLocation>> searchCities(String query) async {
    final response = await _geoDio.get(
      ApiConstants.directGeo,
      queryParameters: {'q': query, 'limit': 5},
    );
    return (response.data as List)
        .map((e) => GeoLocation.fromJson(e))
        .toList();
  }
}
