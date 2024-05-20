import 'package:mobile_weather/repositories/weather_repository.dart';
import 'package:mobile_weather/services/providers/weather_api_services_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_repository_provider.g.dart';

@riverpod
WeatherRepository weatherRepository(WeatherRepositoryRef ref) {
  return WeatherRepository(
      weatherAPIServices: ref.watch(weatherAPIServicesProvider));
}
