import 'package:dream_app_bloc/networking/api_client.dart';
import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:dream_app_bloc/repositories/dream_repository.dart';
import 'package:dream_app_bloc/repositories/user_repository.dart';
import 'package:dream_app_bloc/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  final ApiClient apiClient;
  final AppRouter router;

  const MyApp({Key? key, required this.apiClient, required this.router})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthorizationRepository>(
          create: (context) => AuthorizationRepository(apiClient: apiClient),
        ),
        RepositoryProvider<DreamRepository>(
          create: (context) => DreamRepository(apiClient: apiClient),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(apiClient: apiClient),
        ),
      ],
      child: MaterialApp(
        title: 'Dream App',
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.onGenerateRoute,
      ),
    );
  }
}
