import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather/extentions/async_value_xx.dart';
import 'package:mobile_weather/pages/home/providers/weather_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final weatherState = ref.watch(weatherProvider);
    print("loging: ${weatherState.toStr}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
