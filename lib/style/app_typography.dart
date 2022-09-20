import 'package:dream_app_bloc/style/colors.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  TextStyle authHeader() {
    return const TextStyle(
      color: Colors.white70,
      fontSize: 56,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle authTextField() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 16.0,
    );
  }

  TextStyle authHintStyle() {
    return const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w800,
    );
  }

  TextStyle authErrorStyle() {
    return const TextStyle(
      fontSize: 16.0,
    );
  }

  TextStyle dreamCountStyle() {
    return const TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontSize: 28.0,
    );
  }

  TextStyle dreamCountLableStyle() {
    return const TextStyle(
      color: Colors.black45,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle editProfileStyle(){
    return const TextStyle(
      color: AppColors.dreams,
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    );
  }

    TextStyle editProfileHintStyle() {
    return const TextStyle(
      color: AppColors.dreams,
      fontWeight: FontWeight.w800,
    );
  }

  TextStyle upsertFormStyle(){
    return const TextStyle(
      color: AppColors.dreams,
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    );
  }
    TextStyle upsertHintStyle() {
    return const TextStyle(
      color: AppColors.dreams,
      fontWeight: FontWeight.w800,
    );
  }
}
