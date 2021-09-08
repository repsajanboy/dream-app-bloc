import 'package:dream_app_bloc/presentation/login/login.dart';
import 'package:dream_app_bloc/utils/form_submission_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButtonMD extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const LoginButtonMD({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 40.0,
        right: 40.0,
        top: 5.0,
        bottom: 15.0,
      ),
      child: Column(
        children: [
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return state.formStatus is FormSubmitting
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.orange.shade400,
                            onPrimary: Colors.white,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.all(10.0)),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(LoginSubmitted());
                          }
                        },
                        child: const Text(
                          'SIGN IN',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    );
            },
          ),
          Column(
            children: [
              const Text(
                'By signing in, you are agreeing to our',
                style: TextStyle(color: Colors.white60),
              ),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Term of Service',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                        text: ' and ', style: TextStyle(color: Colors.white60)),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
