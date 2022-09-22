// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dream_app_bloc/presentation/login/bloc/login_bloc.dart';
import 'package:dream_app_bloc/presentation/login/view/widgets/login_button_md.dart';
import 'package:dream_app_bloc/presentation/login/view/widgets/login_form.dart';
import 'package:dream_app_bloc/presentation/login/view/widgets/login_header.dart';
import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:dream_app_bloc/style/glass_container.dart';
import 'package:dream_app_bloc/utils/extension/string_extension.dart';
import 'package:dream_app_bloc/utils/form_submission_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final bool reversed = false;
  LoginPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool _keyboardVisible = false;
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    final bool visible = !(reversed ? !_keyboardVisible : _keyboardVisible);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: BlocProvider(
          create: (context) => LoginBloc(
            authorizationRepository: context.read<AuthorizationRepository>(),
          ),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              final formStatus = state.formStatus;
              if (formStatus is SubmissionSuccess) {
                Navigator.pushReplacementNamed(
                  context,
                  RouteNames.menu,
                  arguments: 0,
                );
              } else if (formStatus is SubmissionFailed) {
                Fluttertoast.showToast(
                  msg: formStatus.error!.errorMessage(),
                  gravity: ToastGravity.TOP,
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                );
              }
            },
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF203f81),
                    Color(0xFF576cd6),
                    Color(0xFF4f67d8),
                    Color(0xFF203f81),
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LoginHeader(
                      visible: visible,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: GlassMorphismContainer(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  LoginForm(
                                    formKey: _formKey,
                                  ),
                                  LoginButtonMD(
                                    formKey: _formKey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
