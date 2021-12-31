import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:dream_app_bloc/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class ResetPasswordVerificationPage extends StatelessWidget {
  ResetPasswordVerificationPage({Key? key}) : super(key: key);
  final _sharedPref = SharedPref();
  @override
  Widget build(BuildContext context) {
    printVerificationCode();
    String inputCode = "";
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
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
              const Text('Please enter the 6 digit we sent to your email'),
              const SizedBox(height: 18.0),
              Center(
                child: VerificationCode(
                  length: 6,
                  underlineColor: Colors.indigo,
                  onCompleted: (String value) {
                    inputCode = value;
                  },
                  onEditing: (bool value) {
                    print(value);
                  },
                ),
              ),
              const SizedBox(height: 18.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                  onPressed: () async {
                    final code = await _sharedPref.readStr("verifyCode");
                    print(code);
                    print(inputCode);
                    if (code == inputCode) {
                      Navigator.pushReplacementNamed(context, RouteNames.resetPassword);
                    } else {
                      print("wrong code");
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
    );
  }

  Future<void> printVerificationCode() async {
    final code = await _sharedPref.readStr("verifyCode");
    print(code);
  }
}
