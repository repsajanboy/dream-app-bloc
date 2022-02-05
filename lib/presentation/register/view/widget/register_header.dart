import 'package:dream_app_bloc/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({Key? key, required this.visible}) : super(key: key);
  final bool visible;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white60,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Visibility(
          visible: visible,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create an',
                  style: context.typo.authHeader(),
                ),
                Text(
                  'Account',
                  style: context.typo.authHeader(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
