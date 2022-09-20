// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dream_app_bloc/presentation/register/register.dart';
import 'package:dream_app_bloc/presentation/register/view/widget/register_button.dart';
import 'package:dream_app_bloc/presentation/register/view/widget/register_form.dart';
import 'package:dream_app_bloc/presentation/register/view/widget/register_header.dart';
import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:dream_app_bloc/style/glass_container.dart';
import 'package:dream_app_bloc/utils/extension/string_extension.dart';
import 'package:dream_app_bloc/utils/form_submission_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final bool reversed = false;

  @override
  Widget build(BuildContext context) {
    bool _keyboardVisible = false;
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    final bool visible = !(reversed ? !_keyboardVisible : _keyboardVisible);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: BlocProvider(
          create: (context) => RegisterBloc(
            authorizationRepository: context.read<AuthorizationRepository>(),
          ),
          child: BlocListener<RegisterBloc, RegisterState>(
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
                  toastLength: Toast.LENGTH_LONG,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                );
              }
            },
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.loginRegisterBG,
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 32.0,
                    right: 16.0,
                    left: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: visible,
                        child: GlassMorphismContainer(
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Stack(
                            children: [
                              Positioned(
                                left: -25,
                                bottom: -15,
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Colors.purple,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: -50,
                                top: -50,
                                child: Container(
                                  width: 300,
                                  height: 300,
                                  decoration: const BoxDecoration(
                                    color: Colors.indigoAccent,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 5,
                                bottom: 5,
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: -200,
                                top: -20,
                                child: Container(
                                  width: 400,
                                  height: 400,
                                  decoration: const BoxDecoration(
                                    color: Colors.deepPurple,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              GlassMorphismContainer(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Column(
                                    children: [
                                      RegisterHeader(visible: visible),
                                      RegisterForm(
                                        formKey: _formKey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      RegisterButton(
                        formKey: _formKey,
                      ),
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
}
