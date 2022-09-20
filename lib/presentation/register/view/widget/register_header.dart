import 'package:dream_app_bloc/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({Key? key, required this.visible}) : super(key: key);
  final bool visible;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        visible: visible,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create an',
              style: context.typo.authHeader(),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              'Account',
              style: context.typo.authHeader(),
            ),
          ],
        ),
      ),
    );
  }
}
