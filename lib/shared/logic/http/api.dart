import 'package:buro_employee/repository/network/auth_token_interceptor.dart';
import 'package:buro_employee/utilities/environments.dart';
import 'package:dio/dio.dart';

export 'package:dio/dio.dart';
import 'dart:convert';

import 'interceptors/dialog_interceptor.dart';
Dio _createHttpClient() {
  String username = '23193';
  String password = '12345';

  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  final api = new Dio(
    new BaseOptions(
      baseUrl: environments.base_url,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      headers: <String, String>{'authorization': basicAuth}

    ),
  );

  api
    //..interceptors.add(new DialogInterceptor())
    ..interceptors.add(new AuthTokenInterceptor(api));
  return api;



}

final api = _createHttpClient();
