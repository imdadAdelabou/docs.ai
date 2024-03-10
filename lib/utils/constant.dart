import 'package:dio/dio.dart';

const apiHost = 'http://192.168.1.23:3001/api';

enum ViewState { idle, busy, error, retrieved }

final dioClient = Dio(
  BaseOptions(
    baseUrl: apiHost,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
  ),
);
