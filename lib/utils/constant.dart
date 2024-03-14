import 'package:dio/dio.dart';

const String apiHost = 'http://192.168.1.23:3001/api';

enum ViewState { idle, busy, error, retrieved }

final Dio dioClient = Dio(
  BaseOptions(
    baseUrl: apiHost,
    headers: <String, dynamic>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  ),
);
