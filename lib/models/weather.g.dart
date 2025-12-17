// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CurrentWeatherImpl _$$CurrentWeatherImplFromJson(Map<String, dynamic> json) =>
    _$CurrentWeatherImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      coord: Coord.fromJson(json['coord'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => WeatherCondition.fromJson(e as Map<String, dynamic>))
          .toList(),
      main: Main.fromJson(json['main'] as Map<String, dynamic>),
      wind: Wind.fromJson(json['wind'] as Map<String, dynamic>),
      clouds: Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
      visibility: (json['visibility'] as num).toInt(),
      dt: (json['dt'] as num).toInt(),
      sys: Sys.fromJson(json['sys'] as Map<String, dynamic>),
      timezone: (json['timezone'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CurrentWeatherImplToJson(
        _$CurrentWeatherImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coord': instance.coord,
      'weather': instance.weather,
      'main': instance.main,
      'wind': instance.wind,
      'clouds': instance.clouds,
      'visibility': instance.visibility,
      'dt': instance.dt,
      'sys': instance.sys,
      'timezone': instance.timezone,
    };

_$CoordImpl _$$CoordImplFromJson(Map<String, dynamic> json) => _$CoordImpl(
      lon: (json['lon'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
    );

Map<String, dynamic> _$$CoordImplToJson(_$CoordImpl instance) =>
    <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
    };

_$WeatherConditionImpl _$$WeatherConditionImplFromJson(
        Map<String, dynamic> json) =>
    _$WeatherConditionImpl(
      id: (json['id'] as num).toInt(),
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$$WeatherConditionImplToJson(
        _$WeatherConditionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

_$MainImpl _$$MainImplFromJson(Map<String, dynamic> json) => _$MainImpl(
      temp: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      tempMin: (json['temp_min'] as num).toDouble(),
      tempMax: (json['temp_max'] as num).toDouble(),
      pressure: (json['pressure'] as num).toInt(),
      humidity: (json['humidity'] as num).toInt(),
      seaLevel: (json['sea_level'] as num?)?.toInt(),
      grndLevel: (json['grnd_level'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MainImplToJson(_$MainImpl instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'sea_level': instance.seaLevel,
      'grnd_level': instance.grndLevel,
    };

_$WindImpl _$$WindImplFromJson(Map<String, dynamic> json) => _$WindImpl(
      speed: (json['speed'] as num).toDouble(),
      deg: (json['deg'] as num).toInt(),
      gust: (json['gust'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$WindImplToJson(_$WindImpl instance) =>
    <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
      'gust': instance.gust,
    };

_$CloudsImpl _$$CloudsImplFromJson(Map<String, dynamic> json) => _$CloudsImpl(
      all: (json['all'] as num).toInt(),
    );

Map<String, dynamic> _$$CloudsImplToJson(_$CloudsImpl instance) =>
    <String, dynamic>{
      'all': instance.all,
    };

_$SysImpl _$$SysImplFromJson(Map<String, dynamic> json) => _$SysImpl(
      type: (json['type'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      country: json['country'] as String?,
      sunrise: (json['sunrise'] as num).toInt(),
      sunset: (json['sunset'] as num).toInt(),
    );

Map<String, dynamic> _$$SysImplToJson(_$SysImpl instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'country': instance.country,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };

_$ForecastResponseImpl _$$ForecastResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ForecastResponseImpl(
      cod: json['cod'] as String,
      cnt: (json['cnt'] as num).toInt(),
      list: (json['list'] as List<dynamic>)
          .map((e) => ForecastItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      city: City.fromJson(json['city'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ForecastResponseImplToJson(
        _$ForecastResponseImpl instance) =>
    <String, dynamic>{
      'cod': instance.cod,
      'cnt': instance.cnt,
      'list': instance.list,
      'city': instance.city,
    };

_$ForecastItemImpl _$$ForecastItemImplFromJson(Map<String, dynamic> json) =>
    _$ForecastItemImpl(
      dt: (json['dt'] as num).toInt(),
      main: Main.fromJson(json['main'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => WeatherCondition.fromJson(e as Map<String, dynamic>))
          .toList(),
      clouds: Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
      wind: Wind.fromJson(json['wind'] as Map<String, dynamic>),
      visibility: (json['visibility'] as num).toInt(),
      pop: (json['pop'] as num).toDouble(),
      dtTxt: json['dt_txt'] as String,
    );

Map<String, dynamic> _$$ForecastItemImplToJson(_$ForecastItemImpl instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'main': instance.main,
      'weather': instance.weather,
      'clouds': instance.clouds,
      'wind': instance.wind,
      'visibility': instance.visibility,
      'pop': instance.pop,
      'dt_txt': instance.dtTxt,
    };

_$CityImpl _$$CityImplFromJson(Map<String, dynamic> json) => _$CityImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      coord: Coord.fromJson(json['coord'] as Map<String, dynamic>),
      country: json['country'] as String,
      population: (json['population'] as num).toInt(),
      timezone: (json['timezone'] as num).toInt(),
      sunrise: (json['sunrise'] as num).toInt(),
      sunset: (json['sunset'] as num).toInt(),
    );

Map<String, dynamic> _$$CityImplToJson(_$CityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coord': instance.coord,
      'country': instance.country,
      'population': instance.population,
      'timezone': instance.timezone,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };

_$GeoLocationImpl _$$GeoLocationImplFromJson(Map<String, dynamic> json) =>
    _$GeoLocationImpl(
      name: json['name'] as String,
      localNames: (json['local_names'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      country: json['country'] as String,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$$GeoLocationImplToJson(_$GeoLocationImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'local_names': instance.localNames,
      'lat': instance.lat,
      'lon': instance.lon,
      'country': instance.country,
      'state': instance.state,
    };
