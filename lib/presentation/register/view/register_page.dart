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
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFbf93e0),
                    Color(0xFF8088db),
                    Color(0xFF1cbaf5),
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16.0),
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
                    RegisterHeader(visible: visible),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: GlassMorphismContainer(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  RegisterForm(formKey: _formKey),
                                  RegisterButton(formKey: _formKey),
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
