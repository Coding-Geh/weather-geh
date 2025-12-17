import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'OPENWEATHER_API_KEY', obfuscate: true)
  static String openWeatherApiKey = _Env.openWeatherApiKey;
}
