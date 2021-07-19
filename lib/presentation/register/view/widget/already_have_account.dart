import 'package:flutter/material.dart';

class AlreadyHaveAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Already have an account? "),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Log In',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        )
      ],
    );
  }
}
