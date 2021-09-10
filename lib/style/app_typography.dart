import 'package:flutter/material.dart';

class AppTextStyle {
  TextStyle authHeader() {
    return const TextStyle(
      color: Colors.white24,
      fontSize: 60,
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
      color: Colors.white70,
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
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    );
  }
}
