// ignore_for_file: use_build_context_synchronously

import 'package:dream_app_bloc/presentation/reset_password/reset_password.dart';
import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:dream_app_bloc/style/glass_container.dart';
import 'package:dream_app_bloc/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
            authorizationRepository: context.read<AuthorizationRepository>(),
          ),
        ),
      ],
      child: Scaffold(
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
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                  ),
                  child: GlassMorphismContainer(
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                      tooltip: 'Back',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: GlassMorphismContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Verification code',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28.0,
                            ),
                          ),
                          const SizedBox(height: 18.0),
                          const Text(
                            'Please enter the 6 digit code we sent to your email',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 18.0),
                          Center(
                            child: VerificationCode(
                              length: 6,
                              underlineColor: Colors.white,
                              underlineUnfocusedColor: Colors.white,
                              onCompleted: (String value) {
                                inputCode = value;
                              },
                              onEditing: (bool value) {},
                            ),
                          ),
                          const SizedBox(height: 18.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Didn't receive code? ",
                                style: TextStyle(color: Colors.white),
                              ),
                              BlocBuilder<ResetPasswordCubit,
                                  ResetPasswordState>(
                                builder: (context, state) {
                                  return TextButton(
                                    onPressed: () async {
                                      String? email = await _sharedPref
                                          .readStr("emailPass");
                                      email = email!.replaceAll('"', '').trim();
                                      context
                                          .read<ResetPasswordCubit>()
                                          .getVerificationCode(email);
                                      Fluttertoast.showToast(
                                        msg:
                                            "Code sent, please check your email",
                                        gravity: ToastGravity.TOP,
                                        toastLength: Toast.LENGTH_SHORT,
                                        backgroundColor: Colors.white,
                                        textColor: Colors.black,
                                      );
                                    },
                                    child: const Text(
                                      'Request Again',
                                      style: TextStyle(color: AppColors.buttonMain),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 18.0),
                          SizedBox(
                            width: double.infinity,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: const Offset(4, 8),
                                    blurRadius: 2,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12.0),
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
                                        BorderRadius.circular(12), // <-- Radius
                                  ),
                                ),
                                onPressed: () async {
                                  // final code =
                                  //     await _sharedPref.readStr("verifyCode");
                                  // print(code);
                                  // if (code == inputCode) {
                                  //   Navigator.pushReplacementNamed(
                                  //     context,
                                  //     RouteNames.resetPassword,
                                  //   );
                                  // } else {
                                  //   Fluttertoast.showToast(
                                  //     msg: "The code is not valid. Try again",
                                  //     gravity: ToastGravity.TOP,
                                  //     toastLength: Toast.LENGTH_SHORT,
                                  //     backgroundColor: Colors.red,
                                  //     textColor: Colors.white,
                                  //   );
                                  // }
                                  Navigator.pushReplacementNamed(
                                    context,
                                    RouteNames.resetPassword,
                                  );
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
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
              ],
            ),
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
