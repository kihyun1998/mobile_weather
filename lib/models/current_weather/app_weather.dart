import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_weather/models/current_weather/current_weather.dart';

part 'app_weather.freezed.dart';

@freezed
class AppWeather with _$AppWeather {
  const factory AppWeather({
    required String name,
    required String country,
    required double temp,
    required double tempMin,
    required double tempMax,
    required String icon,
    required String description,
  }) = _AppWeather;

  factory AppWeather.fromCurrentWeather(CurrentWeather currentWeather) {
    return AppWeather(
      name: currentWeather.name,
      country: currentWeather.sys.country,
      temp: currentWeather.main.temp,
      tempMin: currentWeather.main.tempMin,
      tempMax: currentWeather.main.tempMax,
      icon: currentWeather.weathers[0].icon,
      description: currentWeather.weathers[0].description,
    );
  }
}
