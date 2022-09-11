import 'package:dream_app_bloc/data/dream/dream.dart';
import 'package:dream_app_bloc/presentation/bottom_tab/bottom_tab.dart';
import 'package:dream_app_bloc/presentation/dream/dream.dart';
import 'package:dream_app_bloc/presentation/dream_upsert/upsert_dream.dart';
import 'package:dream_app_bloc/presentation/landing/landing.dart';
import 'package:dream_app_bloc/presentation/login/login.dart';
import 'package:dream_app_bloc/presentation/profile_setting/profile_setting.dart';
import 'package:dream_app_bloc/presentation/register/register.dart';
import 'package:dream_app_bloc/presentation/reset_password/reset_password.dart';
import 'package:dream_app_bloc/presentation/splash/splash.dart';
import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:dream_app_bloc/repositories/dream_repository.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:dream_app_bloc/utils/navigator_arguments/profile_setting_arguments.dart';
import 'package:dream_app_bloc/utils/navigator_arguments/upsert_screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case RouteNames.landing:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case RouteNames.register:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case RouteNames.menu:
        final currIndex = routeSettings.arguments! as int;
        return MaterialPageRoute(
          builder: (_) => BottomNavBarPage(
            currIndex: currIndex,
          ),
        );
      case RouteNames.upsertDream:
        final args = routeSettings.arguments! as UpsertScreenArgument;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => UpsertDreamBloc(
              dreamRepository: context.read<DreamRepository>(),
            ),
            child: UpsertDreamPage(
              isEditing: args.isEditing,
              dream: args.dream,
            ),
          ),
        );
      case RouteNames.dream:
        final dream = routeSettings.arguments! as Dream;
        return MaterialPageRoute(
          builder: (_) => DreamPage(
            dream: dream,
          ),
        );
      case RouteNames.setting:
        final args = routeSettings.arguments! as ProfileSettingArguments;
        return PageRouteBuilder(
          settings:
              routeSettings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              ProfileSettingPage(
            user: args.user!,
          ),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return Stack(
              children: <Widget>[
                SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset.zero,
                    end: const Offset(-1.0, 0.0),
                  ).animate(animation),
                  child: const BottomNavBarPage(
                    currIndex: 1,
                  ),
                ),
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: ProfileSettingPage(
                    user: args.user!,
                  ),
                )
              ],
            );
          },
        );
      case RouteNames.verificationCode:
        return MaterialPageRoute(
          builder: (_) => ResetPasswordVerificationPage(),
        );
      case RouteNames.resetPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => NewPasswordBloc(
              authorizationRepository: context.read<AuthorizationRepository>(),
            ),
            child: ResetPasswordPage(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${routeSettings.name}'),
            ),
          ),
        );
    }
  }
}
