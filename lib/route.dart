import 'package:brik/features/auth/presentation/pages/login.dart';
import 'package:brik/features/auth/presentation/pages/register.dart';
import 'package:brik/features/dashboard/presentation/pages/dashboard.dart';
import 'package:brik/features/splash/presentation/pages/splash.dart';

import 'package:flutter/material.dart';

class AppRoute {

  static Route<dynamic>? controller(RouteSettings settings) {
    switch (settings.name) {
      case SplashPage.route:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case RegisterPage.route:
        return MaterialPageRoute(builder: (context) => const RegisterPage());
      case LoginPage.route:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case DashboardPage.route:
        return MaterialPageRoute(builder: (context) => const DashboardPage());
      default:
        return null;
    }
  }

}