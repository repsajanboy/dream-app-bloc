import 'package:dream_app_bloc/data/dream/dream.dart';
import 'package:dream_app_bloc/presentation/bottom_tab/bottom_tab.dart';
import 'package:dream_app_bloc/presentation/dream_upsert/upsert_dream.dart';
import 'package:dream_app_bloc/presentation/dream/dream.dart';
import 'package:dream_app_bloc/presentation/landing/landing.dart';
import 'package:dream_app_bloc/presentation/login/login.dart';
import 'package:dream_app_bloc/presentation/register/register.dart';
import 'package:dream_app_bloc/presentation/splash/splash.dart';
import 'package:dream_app_bloc/repositories/dream_repository.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:dream_app_bloc/utils/upsert_screen_arguments.dart';
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
        return MaterialPageRoute(builder: (_) => BottomNavBarPage());
      case RouteNames.upsertDream:
        UpsertScreenArgument args =
            routeSettings.arguments as UpsertScreenArgument;
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
        final dream = routeSettings.arguments as Dream;
        return MaterialPageRoute(
          builder: (_) => DreamPage(
            dream: dream,
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
