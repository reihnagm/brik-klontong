import 'package:brik/features/product/presentation/pages/products.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static const String route = '/splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() =>SplashPageState();
}

class SplashPageState extends State<SplashPage> {

  @override 
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () async {
      Navigator.pushNamed(context, ProductsScreen.route);
    });
  }

  @override 
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text("Klontong Shop",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
        )
      )
    );
  }
}