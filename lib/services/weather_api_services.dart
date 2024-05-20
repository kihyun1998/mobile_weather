// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_weather/constants/constants.dart';
import 'package:mobile_weather/exceptions/weather_exceptio.dart';
import 'package:mobile_weather/models/direct_geocoding/direct_geocoding.dart';
import 'package:mobile_weather/services/dio_error_handler.dart';

class WeatherAPIServices {
  final Dio dio;
  WeatherAPIServices({
    required this.dio,
  });

  Future<DirectGeocoding> getDirectGeocoding(String city) async {
    try {
      final Response res = await dio.get('/geo/1.0/direct', queryParameters: {
        'q': city,
        'limit': pubLIMIT,
        'appid': dotenv.env['APPID']
      });
      if (res.statusCode != 200) {
        throw dioErrorHandler(res);
      }

      if (res.data.isEmpty) {
        throw WeatherException('Cannot get the location of $city');
      }

      final directGeocoding = DirectGeocoding.fromJson(res.data[0]);

      return directGeocoding;
    } catch (e) {
      rethrow;
    }
  }
}
