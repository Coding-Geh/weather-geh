import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathergeh_app/models/weather.dart';
import 'package:weathergeh_app/services/weather_service.dart';
import 'package:weathergeh_app/services/location_service.dart';
import 'package:weathergeh_app/services/geolocation_service.dart';
import 'package:weathergeh_app/core/constants/app_constants.dart';

final weatherServiceProvider = Provider((ref) => WeatherService());

final locationServiceProvider = Provider((ref) => LocationService());

final geolocationServiceProvider = Provider((ref) => GeolocationService());

final locationLoadingProvider = StateProvider<bool>((ref) => true);

final locationErrorProvider = StateProvider<String?>((ref) => null);

final currentLocationProvider = StateProvider<Map<String, dynamic>>((ref) => {
  'city': AppConstants.defaultCity,
  'lat': AppConstants.defaultLat,
  'lon': AppConstants.defaultLon,
});

final initLocationProvider = FutureProvider<void>((ref) async {
  final geoService = ref.read(geolocationServiceProvider);
  
  try {
    ref.read(locationLoadingProvider.notifier).state = true;
    ref.read(locationErrorProvider.notifier).state = null;
    
    final position = await geoService.getCurrentPosition();
    
    if (position != null) {
      ref.read(currentLocationProvider.notifier).state = {
        'city': 'Current Location',
        'lat': position.latitude,
        'lon': position.longitude,
      };
    } else {
      ref.read(locationErrorProvider.notifier).state = 'Location permission denied';
    }
  } catch (e) {
    ref.read(locationErrorProvider.notifier).state = 'Error getting location: $e';
  } finally {
    ref.read(locationLoadingProvider.notifier).state = false;
  }
});

final currentWeatherProvider = FutureProvider<CurrentWeather>((ref) async {
  final location = ref.watch(currentLocationProvider);
  final service = ref.read(weatherServiceProvider);
  return service.getCurrentWeather(location['lat'], location['lon']);
});

final forecastProvider = FutureProvider<ForecastResponse>((ref) async {
  final location = ref.watch(currentLocationProvider);
  final service = ref.read(weatherServiceProvider);
  return service.getForecast(location['lat'], location['lon']);
});

final dailyForecastProvider = Provider<List<List<ForecastItem>>>((ref) {
  final forecastAsync = ref.watch(forecastProvider);
  return forecastAsync.when(
    data: (forecast) {
      final Map<String, List<ForecastItem>> grouped = {};
      for (final item in forecast.list) {
        final date = item.dtTxt.split(' ')[0];
        grouped.putIfAbsent(date, () => []).add(item);
      }
      return grouped.values.toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider<List<GeoLocation>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.length < 2) return [];
  final service = ref.read(weatherServiceProvider);
  return service.searchCities(query);
});

final isNightProvider = Provider<bool>((ref) {
  final weatherAsync = ref.watch(currentWeatherProvider);
  return weatherAsync.when(
    data: (weather) {
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      return now < weather.sys.sunrise || now > weather.sys.sunset;
    },
    loading: () => false,
    error: (_, __) => false,
  );
});
