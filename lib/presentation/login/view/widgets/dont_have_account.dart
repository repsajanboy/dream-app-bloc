import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:flutter/material.dart';

class DontHaveAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Don't have an account? "),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.register);
          },
          child: const Text(
            'Register',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        )
      ],
    );
  }
}
