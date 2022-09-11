import 'package:dream_app_bloc/data/horoscope/horoscope.dart';
import 'package:dream_app_bloc/networking/api_client.dart';

class HoroscopeRepository{
  final ApiClient apiClient;

  HoroscopeRepository({required this.apiClient});

  Future<Horoscope> getHoroscope(String sign) async {
    final result = await apiClient.getHoroscope(sign);
    return Horoscope.fromJson(result as Map<String, dynamic>);
  }
}
