import 'package:dream_app_bloc/app.dart';
import 'package:dream_app_bloc/networking/api_client.dart';
import 'package:dream_app_bloc/routing/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(apiClient: ApiClient(), router: AppRouter(),),
  );
}
