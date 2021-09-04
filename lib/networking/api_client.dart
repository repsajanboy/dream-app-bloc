import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dream_app_bloc/data/dream/post_dream.dart';

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

  Future<dynamic> logout(String token) async {
    try {
      const logoutUrl = "$baseUrl/api/auth/logout";
      final logoutResponse = await _dio.get(
        logoutUrl,
        options: Options(headers: {"auth-token": token}),
      );
      return json.decode(logoutResponse.toString());
    } on DioError catch (e) {
      return json.decode(e.response.toString());
    }
  }

  Future<dynamic> fetchDreams(String token) async {
    try {
      const dreamsUrl = "$baseUrl/api/dream";
      final dreamsResponse = await _dio.get(
        dreamsUrl,
        options: Options(headers: {
          "auth-token": token,
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8'
        }),
      );
      final toEncode = json.encode(dreamsResponse.data);
      final response = json.decode(toEncode.replaceAll('_id', 'id'));
      return response;
    } on DioError catch (e) {
      return json.decode(e.response.toString());
    }
  }

  Future<dynamic> postDream(String token, PostDream postDream) async {
    try {
      const postDreamUrl = "$baseUrl/api/dream";
      final postDreamResponse = await _dio.post(
        postDreamUrl,
        options: Options(headers: {
          "auth-token": token,
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8'
        }),
        data: postDream.toJson()
      );
      final toEncode  = json.encode(postDreamResponse.data);
      final response = json.decode(toEncode.replaceAll('_id', 'id'));
      return response;
    } on DioError catch (e) {
      return json.decode(e.response.toString());
    }
  }

  Future<dynamic> updateDream(String token, PostDream updateDream) async {
    try{
      final updateDreamUrl = "$baseUrl/api/dream/${updateDream.id}";
      final postDreamResponse = await _dio.put(
        updateDreamUrl,
        options: Options(headers: {
          "auth-token": token,
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8'
        }),
        data: updateDream.toJson()
      );
      final toEncode  = json.encode(postDreamResponse.data);
      final response = json.decode(toEncode.replaceAll('_id', 'id'));
      return response;
    } on DioError catch (e) {
      return json.decode(e.response.toString());
    }
  }
}
