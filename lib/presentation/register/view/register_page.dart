// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dream_app_bloc/presentation/register/register.dart';
import 'package:dream_app_bloc/presentation/register/view/widget/register_button.dart';
import 'package:dream_app_bloc/presentation/register/view/widget/register_form.dart';
import 'package:dream_app_bloc/presentation/register/view/widget/register_header.dart';
import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.indigoAccent, Colors.indigo.shade900],
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RegisterHeader(visible: visible),
                    SingleChildScrollView(
                      child: RegisterForm(
                        formKey: _formKey,
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
    );
  }
}
