import 'package:dream_app_bloc/style/glass_container.dart';
import 'package:dream_app_bloc/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key, required this.visible}) : super(key: key);
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16.0,
            bottom: 16.0,
          ),
          child: GlassMorphismContainer(
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
        ),
        Visibility(
          visible: visible,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Account',
                  style: context.typo.authHeader(),
                ),
                Text(
                  'Login',
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
