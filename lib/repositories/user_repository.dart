import 'package:dream_app_bloc/data/user/user.dart';
import 'package:dream_app_bloc/networking/api_client.dart';
import 'package:dream_app_bloc/utils/shared_pref.dart';

class UserRepository {
  final ApiClient apiClient;
  final _sharedPref = SharedPref();

  UserRepository({required this.apiClient});

  Future<User> getUserDetails() async {
    String token = (await _sharedPref.readStr("token"))!;
    token = token.replaceAll('"', '').trim();

    final result = await apiClient.getUserDetails(token);
    return User.fromJson(result as Map<String, dynamic>);
  }

  Future<User> updateProfileDetails(Map<String, dynamic> userDetails) async {
    String token = (await _sharedPref.readStr("token"))!;
    token = token.replaceAll('"', '').trim();

    final result = await apiClient.updateProfileDetails(token, userDetails);
    return User.fromJson(result as Map<String, dynamic>);
  }
}
