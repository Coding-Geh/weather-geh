import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:weathergeh_app/core/constants/app_constants.dart';

class LocationService {
  Future<void> saveLastCity(String city, double lat, double lon) async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode({'city': city, 'lat': lat, 'lon': lon});
    await prefs.setString(AppConstants.prefLastCity, data);
  }

  Future<Map<String, dynamic>?> getLastCity() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(AppConstants.prefLastCity);
    if (data == null) return null;
    return jsonDecode(data);
  }

  Future<void> saveUnit(String unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.prefUnit, unit);
  }

  Future<String> getUnit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.prefUnit) ?? 'metric';
  }

  Future<void> addFavoriteLocation(String city, double lat, double lon) async {
    final prefs = await SharedPreferences.getInstance();
    final locations = await getFavoriteLocations();
    final newLocation = {'city': city, 'lat': lat, 'lon': lon};
    
    if (!locations.any((l) => l['city'] == city)) {
      locations.add(newLocation);
      await prefs.setString(AppConstants.prefSavedLocations, jsonEncode(locations));
    }
  }

  Future<List<Map<String, dynamic>>> getFavoriteLocations() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(AppConstants.prefSavedLocations);
    if (data == null) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(data));
  }

  Future<void> removeFavoriteLocation(String city) async {
    final prefs = await SharedPreferences.getInstance();
    final locations = await getFavoriteLocations();
    locations.removeWhere((l) => l['city'] == city);
    await prefs.setString(AppConstants.prefSavedLocations, jsonEncode(locations));
  }
}
