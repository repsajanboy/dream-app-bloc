import 'package:dream_app_bloc/presentation/register/register.dart';
import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:dream_app_bloc/utils/form_submission_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'widget/register_form.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RegisterBloc(
            authorizationRepository: context.read<AuthorizationRepository>()),
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            final formStatus = state.formStatus;
            if (formStatus is SubmissionSuccess) {
              Navigator.pushReplacementNamed(context, RouteNames.menu);
            } else if (formStatus is SubmissionFailed) {
              Fluttertoast.showToast(
                msg: formStatus.error,
                gravity: ToastGravity.BOTTOM,
              );
            }
          },
          child: RegisterForm(),
        ),
      ),
    );
  }
}
