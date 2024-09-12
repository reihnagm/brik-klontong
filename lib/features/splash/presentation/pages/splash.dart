import 'package:brik/common/helpers/storage.dart';

import 'package:brik/features/dashboard/presentation/pages/dashboard.dart';

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
      bool? isLoggedIn = await StorageHelper.isLoggedIn();

      if(isLoggedIn != null) {
        if(isLoggedIn) {
          if(mounted) {
            Navigator.pushNamed(context, DashboardPage.route);
          }
        } else {
          // if(mounted) {
          //   Navigator.pushReplacementNamed(context, LoginPage.route);
          // }
        }
      } else {
        // if(mounted) {
        //   Navigator.pushReplacementNamed(context, LoginPage.route);
        // }
      }

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
        child: Text("Product",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
        )
      )
    );
  }
}