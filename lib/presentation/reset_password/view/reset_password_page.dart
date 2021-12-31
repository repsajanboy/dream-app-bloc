import 'package:dream_app_bloc/style/colors.dart';
import 'package:dream_app_bloc/utils/form_submission_status.dart';
import 'package:flutter/material.dart';
import 'package:dream_app_bloc/utils/extension/context_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../reset_password.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocListener<NewPasswordBloc, NewPasswordState>(
        listener: (context, state) {
          if (state.formStatus is SubmissionSuccess) {
            Navigator.pop(context);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create new password',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Please fill in with your new password',
                    style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  BlocBuilder<NewPasswordBloc, NewPasswordState>(
                    builder: (context, state) {
                      return Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            errorStyle: context.typo.authErrorStyle(),
                            hintText: 'New password',
                            hintStyle: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          validator: (value) => state.isValidPassword
                              ? null
                              : 'Password is too short',
                          onChanged: (value) {
                            context
                                .read<NewPasswordBloc>()
                                .add(NewPasswordChanged(newPassword: value));
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),
                  BlocBuilder<NewPasswordBloc, NewPasswordState>(
                    builder: (context, state) {
                      return Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            errorStyle: context.typo.authErrorStyle(),
                            hintText: 'Confirm password',
                            hintStyle: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          validator: (value) => state.isMatchPassword
                              ? null
                              : 'Password does not match.',
                          onChanged: (value) {
                            context.read<NewPasswordBloc>().add(
                                ConfirmPasswordChanged(confirmPassword: value));
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20.0),
                  BlocBuilder<NewPasswordBloc, NewPasswordState>(
                    builder: (context, state) {
                      return state.formStatus is FormSubmitting
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.indigo.shade900,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12), // <-- Radius
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<NewPasswordBloc>()
                                        .add(NewPasswordSubmitted());
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'Reset Password',
                                    style: TextStyle(
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
