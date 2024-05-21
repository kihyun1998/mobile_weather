import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather/extentions/async_value_xx.dart';
import 'package:mobile_weather/models/current_weather/current_weather.dart';
import 'package:mobile_weather/models/custom_error/error.dart';
import 'package:mobile_weather/pages/home/providers/weather_provider.dart';
import 'package:mobile_weather/pages/home/widgets/show_weather.dart';
import 'package:mobile_weather/pages/search/search_page.dart';
import 'package:mobile_weather/widgets/error_dialog.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String? city;

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<CurrentWeather?>>(weatherProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          errorDialog(context, (error as CustomError).errMsg);
        },
      );
    });

    final weatherState = ref.watch(weatherProvider);
    print("loging: ${weatherState.toStr}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
            onPressed: () async {
              city = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SearchPage(),
              ));
              print(city);
              if (city != null) {
                ref.read(weatherProvider.notifier).fetchWeather(city!);
              }
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: ShowWeather(weatherState: weatherState),
      floatingActionButton: FloatingActionButton(
        onPressed: city == null
            ? null
            : () {
                ref.read(weatherProvider.notifier).fetchWeather(city!);
              },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
