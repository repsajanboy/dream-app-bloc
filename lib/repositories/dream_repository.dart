import 'package:dream_app_bloc/data/dream/dream.dart';
import 'package:dream_app_bloc/networking/api_client.dart';
import 'package:dream_app_bloc/utils/shared_pref.dart';

class DreamRepository {
  final ApiClient apiClient;
  final _sharedPref = SharedPref();

  DreamRepository({required this.apiClient});

  Future<List<Dream>> fetchDreams() async {
    String token = (await _sharedPref.readStr("token"))!;
    token = token.replaceAll('"', '').trim();
    final result = await apiClient.fetchDreams(token) as List;
    return result.cast<Map<String, dynamic>>().map((e) => Dream.fromJson(e)).toList();
  }
}