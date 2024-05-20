import 'package:dio/dio.dart';

String dioErrorHandler(Response res) {
  final code = res.statusCode;
  final msg = res.statusMessage;

  final String errorMsg = "Request failed\n\nStatus Code: $code\nMessage: $msg";
  return errorMsg;
}
