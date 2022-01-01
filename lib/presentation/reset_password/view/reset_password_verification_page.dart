import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:dream_app_bloc/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../reset_password.dart';

class ResetPasswordVerificationPage extends StatelessWidget {
  ResetPasswordVerificationPage({Key? key}) : super(key: key);
  final _sharedPref = SharedPref();
  @override
  Widget build(BuildContext context) {
    printVerificationCode();
    String inputCode = "";
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ResetPasswordCubit(
              authorizationRepository: context.read<AuthorizationRepository>()),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                  ),
                  tooltip: 'Back',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Verification code',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0,
                        ),
                      ),
                      const SizedBox(height: 18.0),
                      const Text(
                          'Please enter the 6 digit code we sent to your email'),
                      const SizedBox(height: 18.0),
                      Center(
                        child: VerificationCode(
                            length: 6,
                            underlineColor: Colors.indigo,
                            onCompleted: (String value) {
                              inputCode = value;
                            },
                            onEditing: (bool value) {}),
                      ),
                      const SizedBox(height: 18.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Didn't receive code? "),
                          BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                            builder: (context, state) {
                              return TextButton(
                                onPressed: () async {
                                  String? email =
                                      await _sharedPref.readStr("emailPass");
                                  email = email!.replaceAll('"', '').trim();
                                  context
                                      .read<ResetPasswordCubit>()
                                      .getVerificationCode(email);
                                  Fluttertoast.showToast(
                                    msg: "Code sent, please check your email",
                                    gravity: ToastGravity.TOP,
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                  );
                                },
                                child: const Text(
                                  'Request Again',
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 18.0),
                      SizedBox(
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
                            final code =
                                await _sharedPref.readStr("verifyCode");
                            if (code == inputCode) {
                              Navigator.pushReplacementNamed(
                                  context, RouteNames.resetPassword);
                            } else {
                              Fluttertoast.showToast(
                                msg: "The code is not valid. Try again",
                                gravity: ToastGravity.TOP,
                                toastLength: Toast.LENGTH_SHORT,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                              );
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> printVerificationCode() async {
    final code = await _sharedPref.readStr("verifyCode");
    print(code);
  }
}
