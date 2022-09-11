import 'package:dream_app_bloc/presentation/reset_password/reset_password.dart';
import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:dream_app_bloc/style/colors.dart';
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
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: const Center(
          child: Text(
            "Reset Password",
            style:
                TextStyle(color: Colors.indigoAccent, fontFamily: 'Circular'),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Text(
                'Enter the email address associated with your account',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Form(
                  key: _formKey,
                  child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                    builder: (context, state) {
                      return TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          errorStyle: context.typo.authErrorStyle(),
                          hintText: 'Email',
                          hintStyle: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        validator: (value) => EmailValidator.validate(value!)
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
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onPrimary: Colors.white,
            ),
            child: const Text('Cancel'),
          ),
          BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    context
                        .read<ResetPasswordCubit>()
                        .getVerificationCode(email);
                    Navigator.pushNamed(context, RouteNames.verificationCode);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigoAccent,
                  onPrimary: Colors.white,
                ),
                child: const Text('Send'),
              );
            },
          ),
        ],
      ),
    );
  }
}
