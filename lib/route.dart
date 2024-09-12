import 'package:brik/features/product/presentation/pages/product.dart';
import 'package:brik/features/product/presentation/pages/products.dart';
import 'package:brik/features/splash/presentation/pages/splash.dart';

import 'package:flutter/material.dart';

class AppRoute {

  static Route<dynamic>? controller(RouteSettings settings) {
    switch (settings.name) {
      case SplashPage.route:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case ProductsScreen.route:
        return MaterialPageRoute(builder: (context) => const ProductsScreen());
      case ProductScreen.route:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(builder: (context) => ProductScreen(id: args["id"]));
      default:
        return null;
    }
  }

}