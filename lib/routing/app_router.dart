import 'package:dream_app_bloc/presentation/bottom_tab/bottom_tab.dart';
import 'package:dream_app_bloc/presentation/dream/view/create_dream_page.dart';
import 'package:dream_app_bloc/presentation/landing/landing.dart';
import 'package:dream_app_bloc/presentation/login/login.dart';
import 'package:dream_app_bloc/presentation/register/register.dart';
import 'package:dream_app_bloc/presentation/splash/splash.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:flutter/material.dart';

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
        return MaterialPageRoute(builder: (_) => BottomNavBarPage());
      case RouteNames.createDream:
        return MaterialPageRoute(builder: (_) => CreateDreamPage());
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
