import 'dart:ui';

import 'package:dream_app_bloc/presentation/register/register.dart';
import 'package:dream_app_bloc/utils/extension/context_extension.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const RegisterForm({Key? key, required this.formKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _firstNameField(),
            const SizedBox(height: 10.0),
            _lastNameField(),
            const SizedBox(height: 10.0),
            _emailField(),
            const SizedBox(height: 10.0),
            _passwordField(),
          ],
        ),
      ),
    );
  }

  Widget _firstNameField() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(.5),
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: Colors.white,
            style: context.typo.authTextField(),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'First Name',
              hintStyle: context.typo.authHintStyle(),
              errorStyle: context.typo.authErrorStyle(),
            ),
            validator: (value) => state.isFirstNameNotEmpty
                ? null
                : 'Please enter your first name.',
            onChanged: (value) {
              context
                  .read<RegisterBloc>()
                  .add(RegisterFirstNameChanged(firstName: value));
            },
          ),
        );
      },
    );
  }

  Widget _lastNameField() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(.5),
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: Colors.white,
            style: context.typo.authTextField(),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Last Name',
              hintStyle: context.typo.authHintStyle(),
              errorStyle: context.typo.authErrorStyle(),
            ),
            validator: (value) => state.isLastNameNotEmpty
                ? null
                : 'Please enter your last name.',
            onChanged: (value) {
              context
                  .read<RegisterBloc>()
                  .add(RegisterLastNameChanged(lastName: value));
            },
          ),
        );
      },
    );
  }

  Widget _emailField() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(.5),
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: Colors.white,
            style: context.typo.authTextField(),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Email Address',
              hintStyle: context.typo.authHintStyle(),
              errorStyle: context.typo.authErrorStyle(),
            ),
            validator: (value) =>
                EmailValidator.validate(value!) ? null : 'Invalid Email',
            onChanged: (value) {
              context
                  .read<RegisterBloc>()
                  .add(RegisterEmailChanged(email: value));
            },
          ),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(.5),
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: Colors.white,
            style: context.typo.authTextField(),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Password',
              hintStyle: context.typo.authHintStyle(),
              errorStyle: context.typo.authErrorStyle(),
              suffixIcon: IconButton(
                onPressed: () {
                  context.read<RegisterBloc>().add(
                        RegisterObscureTextChanged(
                          isObscureText: !state.isObscureText,
                        ),
                      );
                },
                icon: Icon(
                  state.isObscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white70,
                ),
              ),
            ),
            obscureText: !state.isObscureText,
            validator: (value) =>
                state.isValidPassword ? null : 'Password is too short',
            onChanged: (value) {
              context
                  .read<RegisterBloc>()
                  .add(RegisterPasswordChanged(password: value));
            },
          ),
        );
      },
    );
  }
}
