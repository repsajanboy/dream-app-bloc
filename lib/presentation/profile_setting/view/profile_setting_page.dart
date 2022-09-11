import 'package:dream_app_bloc/authentication/authentication.dart';
import 'package:dream_app_bloc/data/user/user.dart';
import 'package:dream_app_bloc/presentation/profile_setting/profile_setting.dart';
import 'package:dream_app_bloc/presentation/profile_setting/view/widget/edit_profile_form.dart';
import 'package:dream_app_bloc/presentation/profile_setting/view/widget/enable_notification_toggle.dart';
import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:dream_app_bloc/repositories/user_repository.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:dream_app_bloc/utils/extension/string_extension.dart';
import 'package:dream_app_bloc/utils/form_submission_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileSettingPage extends StatelessWidget {
  const ProfileSettingPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(
            authorizationRepository: context.read<AuthorizationRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              ProfileSettingBloc(userRepository: context.read<UserRepository>())
                ..add(ProfileSettingEdit(user: user)),
        ),
      ],
      child: WillPopScope(
        onWillPop: () async => false,
        child: DecoratedBox(
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
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.background,
            body: MultiBlocListener(
              listeners: [
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is AuthenticationUnauthenticated) {
                      Navigator.pushReplacementNamed(
                        context,
                        RouteNames.splash,
                      );
                    }
                  },
                ),
                BlocListener<ProfileSettingBloc, ProfileSettingState>(
                  listener: (context, state) {
                    final formStatus = state.formStatus;
                    if (formStatus is SubmissionSuccess) {
                      Navigator.pushNamed(
                        context,
                        RouteNames.menu,
                        arguments: 4,
                      );
                    } else if (formStatus is SubmissionFailed) {
                      Fluttertoast.showToast(
                        msg: formStatus.error!.errorMessage(),
                        gravity: ToastGravity.TOP,
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    }
                  },
                ),
              ],
              child: SizedBox(
                height: double.infinity,
                child: SafeArea(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            _header(),
                            EditProfileForm(
                              user: user,
                            ),
                            EnableNotificationToggle(),
                            _logoutButton(context),
                          ],
                        ),
                      ),
                      _saveChangesButton(),
                      _backButton(context),
                    ],
                  ),
                ),
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

  Widget _saveChangesButton() {
    return Positioned(
      bottom: 0.0,
      child: BlocBuilder<ProfileSettingBloc, ProfileSettingState>(
        builder: (context, state) {
          return Visibility(
            visible: state.someDataChanged,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                onPressed: () {
                  context.read<ProfileSettingBloc>().add(ProfileSaveChanges());
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.indigoAccent,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('SAVE CHANGES'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _header() {
    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 150,
            height: 150,
            margin: const EdgeInsets.only(top: 10, right: 20.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 10,
                  offset: Offset(4, 8), // Shadow position
                ),
              ],
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Align(
                  child: BlocConsumer<ProfileSettingBloc, ProfileSettingState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Text(
                        '${user.firstName[0]}${user.lastName[0]}',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 64.0,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.add_a_photo_rounded,
                    color: Colors.black26.withOpacity(0.2),
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

class ProfileSettingBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
