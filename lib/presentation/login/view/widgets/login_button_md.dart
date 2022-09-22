import 'package:dream_app_bloc/presentation/login/login.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:dream_app_bloc/utils/form_submission_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButtonMD extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const LoginButtonMD({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return state.formStatus is FormSubmitting
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.orange.shade400,
                  ),
                )
              : SizedBox(
                  width: MediaQuery.of(context).size.width * .75,
                  child: GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context.read<LoginBloc>().add(LoginSubmitted());
                      }
                    },
                    child: DecoratedBox(
                      decoration: ShapeDecoration(
                        shape: const StadiumBorder(),
                        shadows: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
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
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
