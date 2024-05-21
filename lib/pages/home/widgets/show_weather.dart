// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather/models/current_weather/app_weather.dart';
import 'package:mobile_weather/models/current_weather/current_weather.dart';
import 'package:mobile_weather/models/custom_error/error.dart';
import 'package:mobile_weather/pages/home/widgets/format_text.dart';
import 'package:mobile_weather/pages/home/widgets/select_city.dart';
import 'package:mobile_weather/pages/home/widgets/show_icon.dart';
import 'package:mobile_weather/pages/home/widgets/show_temperature.dart';

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
        return ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Text(
              appWeather.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  TimeOfDay.fromDateTime(DateTime.now()).format(context),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 10),
                Text(
                  "(${appWeather.country})",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShowTemperature(
                  temperature: appWeather.temp,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    ShowTemperature(
                      temperature: appWeather.tempMax,
                      fontSize: 16,
                    ),
                    ShowTemperature(
                      temperature: appWeather.tempMin,
                      fontSize: 16,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Spacer(),
                ShowIcon(icon: appWeather.icon),
                Expanded(
                    flex: 3,
                    child: FormatText(description: appWeather.description)),
                const Spacer(),
              ],
            )
          ],
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
