import 'package:dream_app_bloc/presentation/login/bloc/login_bloc.dart';
import 'package:dream_app_bloc/presentation/login/view/widgets/login_form.dart';
import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:dream_app_bloc/utils/form_submission_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => LoginBloc(
          authorizationRepository: context.read<AuthorizationRepository>()),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionSuccess) {
            Navigator.pushReplacementNamed(context, RouteNames.menu);
          } else if (formStatus is SubmissionFailed) {
            Fluttertoast.showToast(
              msg: formStatus.error.toString(),
              gravity: ToastGravity.BOTTOM,
            );
          }
        },
        child: LoginForm(),
      ),
    ));
  }
}
