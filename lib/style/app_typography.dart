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
}
