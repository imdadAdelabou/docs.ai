import 'package:dio/dio.dart';

/// Contains the base url of the api
const String apiHost = 'http://192.168.1.23:3001/api';

/// Represents the states of the a view (app screen)
enum ViewState {
  /// Idle, the widget is a rest state
  idle,

  /// The widget is doing some task
  busy,

  /// The widget is handled an error
  error,

  /// The widget finish a task and retrieved a data
  retrieved,
}

/// An instance of Dio service to communicate with an API
final Dio dioClient = Dio(
  BaseOptions(
    baseUrl: apiHost,
    headers: <String, dynamic>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  ),
);
