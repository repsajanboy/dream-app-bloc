import 'package:dream_app_bloc/presentation/login/login.dart';
import 'package:dream_app_bloc/presentation/reset_password/reset_password.dart';
import 'package:dream_app_bloc/utils/extension/context_extension.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const LoginForm({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _emailField(),
            const SizedBox(height: 10.0),
            _passwordField(),
            const SizedBox(height: 10.0),
            _forgotPassword(context),
          ],
        ),
      ),
    );
  }

  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(
              color: Colors.white,
            ),
          ),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: Colors.white,
            style: context.typo.authTextField(),
            decoration: InputDecoration(
              border: InputBorder.none,
              errorStyle: context.typo.authErrorStyle(),
              hintText: 'Email',
              hintStyle: context.typo.authHintStyle(),
            ),
            validator: (value) =>
                EmailValidator.validate(value!) ? null : 'Invalid email',
            onChanged: (value) =>
                context.read<LoginBloc>().add(LoginEmailChanged(email: value)),
          ),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(
              color: Colors.white,
            ),
          ),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: Colors.white,
            style: context.typo.authTextField(),
            obscureText: !state.isObscureText,
            decoration: InputDecoration(
              errorStyle: context.typo.authErrorStyle(),
              suffixIcon: IconButton(
                onPressed: () {
                  context.read<LoginBloc>().add(
                        LoginObscureTextChanged(
                          isObscureText: !state.isObscureText,
                        ),
                      );
                },
                icon: Icon(
                  state.isObscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
              ),
              hintText: 'Password',
              hintStyle: context.typo.authHintStyle(),
              border: InputBorder.none,
            ),
            validator: (value) =>
                state.isValidPassword ? null : 'Password is too short',
            onChanged: (value) => context
                .read<LoginBloc>()
                .add(LoginPasswordChanged(password: value)),
          ),
        );
      },
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => showOptionsDialog(context),
        child: const Text(
          'FORGOT?',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    );
  }
}

Future<void> showOptionsDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext build) {
      return ResetPasswordModal();
    },
  );
}
