import 'package:dream_app_bloc/style/colors.dart';
import 'package:flutter/material.dart';

class DreamFailedFetch extends StatelessWidget {
  const DreamFailedFetch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Image.asset('assets/icons/dreamfailed.jpg'),
          const Text(
            'Failed to fetch dreams',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.dreams,
            ),
          ),
          const Text(
            "There's an error occured. Please check your internet connection or refreshed the app.",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
