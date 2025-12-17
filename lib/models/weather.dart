import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';
part 'weather.g.dart';

@freezed
class CurrentWeather with _$CurrentWeather {
  const factory CurrentWeather({
    required int id,
    required String name,
    required Coord coord,
    required List<WeatherCondition> weather,
    required Main main,
    required Wind wind,
    required Clouds clouds,
    required int visibility,
    required int dt,
    required Sys sys,
    int? timezone,
  }) = _CurrentWeather;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);
}

@freezed
class Coord with _$Coord {
  const factory Coord({
    required double lon,
    required double lat,
  }) = _Coord;

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);
}

@freezed
class WeatherCondition with _$WeatherCondition {
  const factory WeatherCondition({
    required int id,
    required String main,
    required String description,
    required String icon,
  }) = _WeatherCondition;

  factory WeatherCondition.fromJson(Map<String, dynamic> json) =>
      _$WeatherConditionFromJson(json);
}

@freezed
class Main with _$Main {
  const factory Main({
    required double temp,
    @JsonKey(name: 'feels_like') required double feelsLike,
    @JsonKey(name: 'temp_min') required double tempMin,
    @JsonKey(name: 'temp_max') required double tempMax,
    required int pressure,
    required int humidity,
    @JsonKey(name: 'sea_level') int? seaLevel,
    @JsonKey(name: 'grnd_level') int? grndLevel,
  }) = _Main;

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);
}

@freezed
class Wind with _$Wind {
  const factory Wind({
    required double speed,
    required int deg,
    double? gust,
  }) = _Wind;

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);
}

@freezed
class Clouds with _$Clouds {
  const factory Clouds({
    required int all,
  }) = _Clouds;

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);
}

@freezed
class Sys with _$Sys {
  const factory Sys({
    int? type,
    int? id,
    String? country,
    required int sunrise,
    required int sunset,
  }) = _Sys;

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);
}

@freezed
class ForecastResponse with _$ForecastResponse {
  const factory ForecastResponse({
    required String cod,
    required int cnt,
    required List<ForecastItem> list,
    required City city,
  }) = _ForecastResponse;

  factory ForecastResponse.fromJson(Map<String, dynamic> json) =>
      _$ForecastResponseFromJson(json);
}

@freezed
class ForecastItem with _$ForecastItem {
  const factory ForecastItem({
    required int dt,
    required Main main,
    required List<WeatherCondition> weather,
    required Clouds clouds,
    required Wind wind,
    required int visibility,
    required double pop,
    @JsonKey(name: 'dt_txt') required String dtTxt,
  }) = _ForecastItem;

  factory ForecastItem.fromJson(Map<String, dynamic> json) =>
      _$ForecastItemFromJson(json);
}

@freezed
class City with _$City {
  const factory City({
    required int id,
    required String name,
    required Coord coord,
    required String country,
    required int population,
    required int timezone,
    required int sunrise,
    required int sunset,
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}

@freezed
class GeoLocation with _$GeoLocation {
  const factory GeoLocation({
    required String name,
    @JsonKey(name: 'local_names') Map<String, String>? localNames,
    required double lat,
    required double lon,
    required String country,
    String? state,
  }) = _GeoLocation;

  factory GeoLocation.fromJson(Map<String, dynamic> json) =>
      _$GeoLocationFromJson(json);
}
