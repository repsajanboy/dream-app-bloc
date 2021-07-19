import 'package:dream_app_bloc/authentication/authentication.dart';
import 'package:dream_app_bloc/networking/api_client.dart';
import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  final ApiClient apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthenticationBloc(
        authorizationRepository: context.read<AuthorizationRepository>(),
      )..add(AppStarted()),
      child: SplashView(),
    );
  }
}

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationAuthenticated) {
          Navigator.pushReplacementNamed(context, RouteNames.menu);
        } else if (state is AuthenticationUnauthenticated) {
          Navigator.pushReplacementNamed(context, RouteNames.login);
        }
      },
      child: _splashWidget(),
    );
  }

  Widget _splashWidget() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
