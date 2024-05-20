import 'package:mobile_weather/services/providers/dio_provider.dart';
import 'package:mobile_weather/services/weather_api_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_api_services_provider.g.dart';

@riverpod
WeatherAPIServices weatherAPIServices(WeatherAPIServicesRef ref) {
  return WeatherAPIServices(dio: ref.watch(dioProvider));
}
