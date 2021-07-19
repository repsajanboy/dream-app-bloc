import 'package:dream_app_bloc/authentication/authentication.dart';
import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthenticationBloc(
            authorizationRepository: context.read<AuthorizationRepository>()),
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationUnauthenticated) {
              Navigator.pushReplacementNamed(context, RouteNames.splash);
            }
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Profile Page'),
                _logoutButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logoutButton(context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return state is AuthenticationLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  context.read<AuthenticationBloc>().add(LogOut());
                },
                child: const Text('Log Out'));
      },
    );
  }
}
