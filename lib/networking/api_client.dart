import 'dart:convert';

import 'package:dio/dio.dart';

const baseUrl = "http://10.0.2.2:3000";

class ApiClient {
  Dio _dio = new Dio();

  Future<dynamic> login(Map<String, String> loginCredentials) async {
    try {
      const loginUrl = "$baseUrl/api/auth/login";
      final loginResponse = await _dio.post(loginUrl, data: loginCredentials);
      return json.decode(loginResponse.toString());
    } on DioError catch (e) {
      return json.decode(e.response.toString());
    }
  }

  Future<dynamic> register(Map<String, String> registerObj) async {
    try {
      const registerUrl = "$baseUrl/api/auth/register";
      final registerResponse = await _dio.post(registerUrl, data: registerObj);
      return json.decode(registerResponse.toString());
    } on DioError catch (e) {
      return json.decode(e.response.toString());
    }
  }

}
