import 'package:dream_app_bloc/style/app_typography.dart';
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  AppTextStyle get typo => AppTextStyle();
}

extension StfulContextExtensions on State {
  AppTextStyle get typo => AppTextStyle();
}