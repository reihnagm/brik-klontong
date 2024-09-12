
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:brik/route.dart';

import 'package:brik/common/helpers/storage.dart';

import 'package:brik/global.dart';
import 'package:brik/providers.dart';

import 'package:brik/injection.dart' as di;

import 'package:brik/features/splash/presentation/pages/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StorageHelper.init();

  di.init();

  runApp(MultiProvider(
    providers: providers,
    child: const MyApp()
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override 
  void initState() {
    super.initState();
  }

  @override 
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple
        ),
        useMaterial3: true,
      ),          
      onGenerateRoute: AppRoute.controller,
      initialRoute: SplashPage.route,
    );
  }
}