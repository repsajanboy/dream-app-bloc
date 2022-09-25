import 'package:dream_app_bloc/presentation/reset_password/reset_password.dart';
import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:dream_app_bloc/style/glass_container.dart';
import 'package:dream_app_bloc/utils/extension/context_extension.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordModal extends StatelessWidget {
  ResetPasswordModal({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String email = "";
    return BlocProvider(
      create: (context) => ResetPasswordCubit(
        authorizationRepository: context.read<AuthorizationRepository>(),
      ),
      child: AlertDialog(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * .43,
          child: GlassMorphismContainer(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Reset Password",
                        style: TextStyle(
                          color: AppColors.buttonMain,
                          fontFamily: 'Circular',
                          fontSize: 20.0,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Column(
                    children: [
                      const Text(
                        'Enter the email address associated with your account',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: BlocBuilder<ResetPasswordCubit,
                              ResetPasswordState>(
                            builder: (context, state) {
                              return TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorStyle: context.typo.authErrorStyle(),
                                  hintText: 'Email',
                                  hintStyle: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                validator: (value) =>
                                    EmailValidator.validate(value!)
                                        ? null
                                        : 'Invalid email',
                                onChanged: (value) {
                                  email = value;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(context);
                                // context
                                //     .read<ResetPasswordCubit>()
                                //     .getVerificationCode(email);
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.verificationCode,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.buttonMain,
                              onPrimary: Colors.white,
                            ),
                            child: const Text('Send'),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
