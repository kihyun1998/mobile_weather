// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:mobile_weather/exceptions/weather_exceptio.dart';
import 'package:mobile_weather/models/current_weather/current_weather.dart';
import 'package:mobile_weather/models/custom_error/error.dart';
import 'package:mobile_weather/models/direct_geocoding/direct_geocoding.dart';
import 'package:mobile_weather/services/weather_api_services.dart';

class WeatherRepository {
  final WeatherAPIServices weatherAPIServices;
  WeatherRepository({
    required this.weatherAPIServices,
  });

  Future<CurrentWeather> fetchWeather(String city) async {
    try {
      final DirectGeocoding directGeocoding =
          await weatherAPIServices.getDirectGeocoding(city);
      log("[geocoding]: $directGeocoding");

      final CurrentWeather tempWeather =
          await weatherAPIServices.getWeather(directGeocoding);
      final CurrentWeather currentWeather = tempWeather.copyWith(
        name: directGeocoding.name,
        sys: tempWeather.sys.copyWith(
          country: directGeocoding.country,
        ),
      );

      log("[currentWeather]: $currentWeather");

      return currentWeather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
