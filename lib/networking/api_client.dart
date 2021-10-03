import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dream_app_bloc/data/dream/post_dream.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const baseUrl = "http://10.0.2.2:3000";

class ApiClient {
  Dio _dio = new Dio();

  Future<dynamic> login(Map<String, String> loginCredentials) async {
    try {
      const loginUrl = "$baseUrl/api/auth/login";
      final loginResponse = await _dio.post(loginUrl, data: loginCredentials);
      return json.decode(loginResponse.toString());
    } on DioError catch (e) {
      final err = json.decode(e.response.toString());
      throw Exception(err['msg']);
    }
  }

  Future<dynamic> register(Map<String, String> registerObj) async {
    try {
      const registerUrl = "$baseUrl/api/auth/register";
      final registerResponse = await _dio.post(registerUrl, data: registerObj);
      return json.decode(registerResponse.toString());
    } on DioError catch (e) {
      final err = json.decode(e.response.toString());
      throw Exception(err['msg']);
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
      final err = json.decode(e.response.toString());
      throw Exception(err['msg']);
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
      final err = json.decode(e.response.toString());
      throw Exception(err['msg']);
    }
  }

  Future<dynamic> postDream(String token, PostDream postDream) async {
    try {
      const postDreamUrl = "$baseUrl/api/dream";
      final postDreamResponse = await _dio.post(postDreamUrl,
          options: Options(headers: {
            "auth-token": token,
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8'
          }),
          data: postDream.toJson());
      final toEncode = json.encode(postDreamResponse.data);
      final response = json.decode(toEncode.replaceAll('_id', 'id'));
      return response;
    } on DioError catch (e) {
      final err = json.decode(e.response.toString());
      throw Exception(err['msg']);
    }
  }

  Future<dynamic> updateDream(String token, PostDream updateDream) async {
    try {
      final updateDreamUrl = "$baseUrl/api/dream/${updateDream.id}";
      final postDreamResponse = await _dio.put(updateDreamUrl,
          options: Options(headers: {
            "auth-token": token,
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8'
          }),
          data: updateDream.toJson());
      final toEncode = json.encode(postDreamResponse.data);
      final response = json.decode(toEncode.replaceAll('_id', 'id'));
      return response;
    } on DioError catch (e) {
      final err = json.decode(e.response.toString());
      throw Exception(err['msg']);
    }
  }

  Future<dynamic> getUserDetails(String token) async {
    try {
      const userDetailsUrl = '$baseUrl/api/user/details';
      final userDetailsResponse = await _dio.get(
        userDetailsUrl,
        options: Options(
          headers: {
            "auth-token": token,
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8'
          },
        ),
      );

      return json.decode(userDetailsResponse.toString());
    } on DioError catch (e) {
      final err = json.decode(e.response.toString());
      throw Exception(err['msg']);
    }
  }

  Future<dynamic> updateProfileDetails(
    String token,
    Map<String, dynamic> userDetails,
  ) async {
    try {
      const profileUpdateUrl = '$baseUrl/api/user/';
      final profileUpdateResponse = await _dio.put(
        profileUpdateUrl,
        options: Options(
          headers: {
            "auth-token": token,
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8'
          },
        ),
        data: userDetails,
      );
      return json.decode(profileUpdateResponse.toString());
    } on DioError catch (e) {
      final err = json.decode(e.response.toString());
      throw Exception(err['msg']);
    }
  }

  Future<dynamic> fetchFavoriteDreams(String token) async {
    try {
      const dreamsUrl = "$baseUrl/api/dream/favorites";
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
      final err = json.decode(e.response.toString());
      throw Exception(err['msg']);
    }
  }

  Future<dynamic> updateFavoriteDream(
      String token, String dreamId, Map<String, dynamic> updateFavorite) async {
    try {
      final updateDreamUrl = "$baseUrl/api/dream/$dreamId";
      final postDreamResponse = await _dio.put(
        updateDreamUrl,
        options: Options(headers: {
          "auth-token": token,
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8'
        }),
        data: updateFavorite,
      );
      final toEncode = json.encode(postDreamResponse.data);
      final response = json.decode(toEncode.replaceAll('_id', 'id'));
      return response;
    } on DioError catch (e) {
      final err = json.decode(e.response.toString());
      throw Exception(err['msg']);
    }
  }

  Future<dynamic> getHoroscope(String sign) async {
    try {
      final horoscopeUrl =
          "https://sameer-kumar-aztro-v1.p.rapidapi.com/?sign=$sign&day=today";
      final response = await _dio.post(horoscopeUrl,
          options: Options(headers: {
            'x-rapidapi-host': dotenv.env['HOROSCOPE_API_HOST'],
            'x-rapidapi-key': dotenv.env['HOROSCOPE_API_KEY']
          }));
      return json.decode(response.toString());
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> deleteDream(String token, String dreamId) async {
    try {
      final deleteDreamUrl = "$baseUrl/api/dream/$dreamId";
      final deleteResponse = await _dio.delete(
        deleteDreamUrl,
        options: Options(headers: {
          "auth-token": token,
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8'
        }),
      );
      final toEncode = json.encode(deleteResponse.data);
      final response = json.decode(toEncode.replaceAll('_id', 'id'));
      return response;
    } on DioError catch (e) {
      final err = json.decode(e.response.toString());
      throw Exception(err['msg']);
    }
  }
}
