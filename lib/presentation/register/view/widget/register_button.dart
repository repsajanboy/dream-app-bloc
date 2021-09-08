import 'package:dream_app_bloc/utils/form_submission_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../register.dart';

class RegisterButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const RegisterButton({Key? key, required this.formKey}) : super(key: key);

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
          BlocBuilder<RegisterBloc, RegisterState>(
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
                            context
                                .read<RegisterBloc>()
                                .add(RegisterSubmitted());
                          }
                        },
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
