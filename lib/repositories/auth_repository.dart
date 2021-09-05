import 'dart:convert';

import 'package:dream_app_bloc/networking/api_client.dart';
import 'package:dream_app_bloc/utils/shared_pref.dart';

class AuthorizationRepository {
  final ApiClient apiClient;
  final _sharedPref = SharedPref();
  AuthorizationRepository({required this.apiClient});

  Future<bool> checkUser() async {
    final hasUser = await _sharedPref.isExisting("token");
    return Future.delayed(const Duration(seconds: 5), () => hasUser);
  }

  Future<dynamic> login(String email, String password) async {
    final loginObj = {"email": email, "password": password};
    final result = await apiClient.login(loginObj);

    if (result["token"] != null) {
      _sharedPref.save("token", result["token"]);
      return result;
    }
  }

  Future<dynamic> register(
      String firstName, String lastName, String email, String password) async {
    final registerObj = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
    };

    final result = await apiClient.register(registerObj);

    if (result["token"] != null) {
      _sharedPref.save("token", result["token"]);
      return result;
    }
  }

  Future<dynamic> logout() async {
    String token = (await _sharedPref.readStr("token"))!;
    token = token.replaceAll('"', '').trim();
    final result = await apiClient.logout(token);
    if (result["success"] == true) {
      _sharedPref.clear();
    }
    return result;
  }
}
