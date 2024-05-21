// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather/models/current_weather/app_weather.dart';
import 'package:mobile_weather/models/current_weather/current_weather.dart';
import 'package:mobile_weather/models/custom_error/error.dart';
import 'package:mobile_weather/pages/home/widgets/select_city.dart';

class ShowWeather extends ConsumerWidget {
  final AsyncValue<CurrentWeather?> weatherState;
  const ShowWeather({
    super.key,
    required this.weatherState,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return weatherState.when(
      skipError: true,
      data: (CurrentWeather? data) {
        print("data");

        if (data == null) {
          return const SelectCity();
        }
        final appWeather = AppWeather.fromCurrentWeather(data);
        return Center(
          child: Text(
            appWeather.name,
            style: const TextStyle(fontSize: 18),
          ),
        );
      },
      error: (error, stackTrace) {
        print("error");
        if (weatherState.value == null) {
          return const SelectCity();
        }
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              (error as CustomError).errMsg,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
