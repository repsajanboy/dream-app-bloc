import 'package:dream_app_bloc/style/colors.dart';
import 'package:flutter/material.dart';

class NoFavoriteDream extends StatelessWidget {
  const NoFavoriteDream({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Image.asset('assets/icons/emptyfave.jpg'),
          const Text(
            'No favorite dreams yet',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.dreams,
            ),
          ),
          const Text(
            'Saved your remarkable dream now.',
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
