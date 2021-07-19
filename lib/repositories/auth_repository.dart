import 'package:dream_app_bloc/networking/api_client.dart';
import 'package:dream_app_bloc/utils/shared_pref.dart';

class AuthorizationRepository {
  final ApiClient apiClient;
  final _sharedPref = SharedPref();
  AuthorizationRepository({this.apiClient});

  Future<bool> checkUser() async {
    final hasUser = await _sharedPref.isExisting("token");
    return hasUser;
  }

  Future<dynamic> login(String email, String password) async {
    final loginObj = {"email": email, "password": password};

    final result = await apiClient.login(loginObj);

    if (result["token"] != null) {
      _sharedPref.save("token", result["token"]);
      return result;
    } else {
      return result;
    }
  }

  Future<dynamic> register(String name, String email, String password) async {
    final registerObj = {
      "name": name,
      "email": email,
      "password": password,
    };

    final result = await apiClient.register(registerObj);

    if (result["token"] != null) {
      _sharedPref.save("token", result["token"]);
      return result;
    } else {
      return result;
    }
  }
}
