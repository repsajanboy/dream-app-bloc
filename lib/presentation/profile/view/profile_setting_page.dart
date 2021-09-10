import 'package:dream_app_bloc/authentication/authentication.dart';
import 'package:dream_app_bloc/presentation/profile/profile.dart';
import 'package:dream_app_bloc/presentation/profile/view/widgets/edit_profile_form.dart';
import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:dream_app_bloc/repositories/user_repository.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSettingPage extends StatelessWidget {
  const ProfileSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
              authorizationRepository: context.read<AuthorizationRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) =>
                ProfileBloc(userRepository: context.read<UserRepository>())
                  ..add(const ProfileFetched()),
          ),
        ],
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationUnauthenticated) {
              Navigator.pushReplacementNamed(context, RouteNames.splash);
            }
          },
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.indigoAccent,
                  Colors.indigo.shade900,
                ],
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        _header(context),
                        const EditProfileForm(),
                        _logoutButton(context),
                      ],
                    ),
                  ),
                  _backButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return Positioned(
      top: 0.0,
      child: Align(
        alignment: Alignment.topLeft,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.indigoAccent,
            onPrimary: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(18.0),
                bottomRight: Radius.circular(18.0),
              ),
            ),
            shadowColor: Colors.black,
          ),
          child: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 150,
            height: 150,
            margin: const EdgeInsets.only(top: 10, right: 20.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(18.0)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 10,
                  offset: Offset(4, 8), // Shadow position
                ),
              ],
              color: Colors.indigo.shade900,
            ),
            child: Stack(
              children: [
                Align(
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileFetchedSuccess) {
                        return Text(
                          '${state.user.firstName[0]}${state.user.lastName[0]}',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 64.0,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.add_a_photo_rounded,
                    color: Colors.white.withOpacity(0.8),
                    size: 48.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _logoutButton(context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return state is AuthenticationLoading
            ? const CircularProgressIndicator()
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                height: 80,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(LogOut());
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigoAccent,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text('SIGN OUT'),
                ),
              );
      },
    );
  }
}
