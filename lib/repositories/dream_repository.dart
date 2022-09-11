import 'package:dream_app_bloc/data/dream/dream.dart';
import 'package:dream_app_bloc/data/dream/post_dream.dart';
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

  Future<Dream> postDream(PostDream postDream) async {
    String token = (await _sharedPref.readStr("token"))!;
    token = token.replaceAll('"', '').trim();

    final result = await apiClient.postDream(token, postDream);
    return Dream.fromJson(result as Map<String, dynamic>);
  }

  Future<Dream> updateDream(PostDream updateDream) async {
    String token = (await _sharedPref.readStr("token"))!;
    token = token.replaceAll('"', '').trim();

    final result = await apiClient.updateDream(token, updateDream);
    return Dream.fromJson(result as Map<String, dynamic>);
  }

  Future<List<Dream>> fetchFavoriteDreams() async {
    String token = (await _sharedPref.readStr("token"))!;
    token = token.replaceAll('"', '').trim();

    final result = await apiClient.fetchFavoriteDreams(token) as List;
    return result.cast<Map<String, dynamic>>().map((e) => Dream.fromJson(e)).toList();
  }

  Future<Dream> updateFavoriteDream(String dreamId, Map<String, dynamic> updateFavorite) async {
    String token = (await _sharedPref.readStr("token"))!;
    token = token.replaceAll('"', '').trim();

    final result = await apiClient.updateFavoriteDream(token, dreamId, updateFavorite);
    return Dream.fromJson(result as Map<String, dynamic>);
  }

  Future<dynamic> deleteDream(String dreamId) async {
    String token = (await _sharedPref.readStr("token"))!;
    token = token.replaceAll('"', '').trim();

    final result = await apiClient.deleteDream(token, dreamId);
    return result;
  }
}
