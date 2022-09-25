import 'package:dream_app_bloc/presentation/reset_password/reset_password.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:dream_app_bloc/style/glass_container.dart';
import 'package:dream_app_bloc/utils/extension/context_extension.dart';
import 'package:dream_app_bloc/utils/form_submission_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
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
        child: BlocListener<NewPasswordBloc, NewPasswordState>(
          listener: (context, state) {
            if (state.formStatus is SubmissionSuccess) {
              Navigator.pop(context);
            }
          },
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: GlassMorphismContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                'Create new password',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            const Text(
                              'Please fill in with your new password',
                              style: TextStyle(
                                color: Colors.white60,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 48.0),
                            BlocBuilder<NewPasswordBloc, NewPasswordState>(
                              builder: (context, state) {
                                return Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18.0),
                                      border: Border.all(
                                        color: Colors.white,
                                      )),
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    obscureText: !state.isObscureText,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      errorStyle: context.typo.authErrorStyle(),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          context.read<NewPasswordBloc>().add(
                                                IsObscureTextChanged(
                                                  isObscureText:
                                                      !state.isObscureText,
                                                ),
                                              );
                                        },
                                        icon: Icon(
                                          state.isObscureText
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.white,
                                        ),
                                      ),
                                      hintText: 'New password',
                                      hintStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    validator: (value) => state.isValidPassword
                                        ? null
                                        : 'Password is too short',
                                    onChanged: (value) {
                                      context.read<NewPasswordBloc>().add(
                                            NewPasswordChanged(
                                              newPassword: value,
                                            ),
                                          );
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
                                    borderRadius: BorderRadius.circular(18.0),
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    obscureText: !state.isObscureText,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      errorStyle: context.typo.authErrorStyle(),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          context.read<NewPasswordBloc>().add(
                                                IsObscureTextChanged(
                                                  isObscureText:
                                                      !state.isObscureText,
                                                ),
                                              );
                                        },
                                        icon: Icon(
                                          state.isObscureText
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.white,
                                        ),
                                      ),
                                      hintText: 'Confirm password',
                                      hintStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    validator: (value) => state.isMatchPassword
                                        ? null
                                        : 'Password does not match.',
                                    onChanged: (value) {
                                      context.read<NewPasswordBloc>().add(
                                            ConfirmPasswordChanged(
                                              confirmPassword: value,
                                            ),
                                          );
                                    },
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 20.0),
                            BlocBuilder<NewPasswordBloc, NewPasswordState>(
                              builder: (context, state) {
                                return state.formStatus is FormSubmitting
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : SizedBox(
                                        width: double.infinity,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                offset: const Offset(4, 8),
                                                blurRadius: 2,
                                              )
                                            ],
                                            gradient: const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Colors.deepPurple,
                                                AppColors.buttonMain,
                                              ],
                                            ),
                                          ),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.transparent,
                                              elevation: 0.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  12,
                                                ), // <-- Radius
                                              ),
                                            ),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                context
                                                    .read<NewPasswordBloc>()
                                                    .add(
                                                        NewPasswordSubmitted());
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
                                        ),
                                      );
                              },
                            ),
                            const SizedBox(height: 16.0,),
                          ],
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
    );
  }
}
