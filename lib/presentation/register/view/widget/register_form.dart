import 'package:dream_app_bloc/presentation/register/register.dart';
import 'package:dream_app_bloc/presentation/register/view/widget/already_have_account.dart';
import 'package:dream_app_bloc/utils/form_submission_status.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _nameField(),
            _emailField(),
            _passwordField(),
            _registerButton(context),
            AlreadyHaveAccount(),
          ],
        ),
      ),
    );
  }

  Widget _nameField() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'Full Name',
          ),
          validator: (value) => state.isNameNotEmpty ? null : 'Please enter your name.',
          onChanged: (value) {
            context.read<RegisterBloc>().add(RegisterNameChanged(name: value));
          },
        );
      },
    );
  }

  Widget _emailField() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.email),
            hintText: 'Email Address',
          ),
          validator: (value) =>
              EmailValidator.validate(value) ? null : 'Invalid Email',
          onChanged: (value) {
            context
                .read<RegisterBloc>()
                .add(RegisterEmailChanged(email: value));
          },
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.security),
            hintText: 'Password',
          ),
          validator: (value) =>
              state.isValidPassword ? null : 'Password is too short',
          onChanged: (value) {
            context
                .read<RegisterBloc>()
                .add(RegisterPasswordChanged(password: value));
          },
        );
      },
    );
  }

  Widget _registerButton(context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                context.read<RegisterBloc>().add(RegisterSubmitted());
              }
            },
            child: const Text('Register'));
      },
    );
  }
}
