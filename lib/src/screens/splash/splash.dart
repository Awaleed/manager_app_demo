import 'package:flutter/material.dart';

import '../../repositories/users_repository.dart';
import '../auth/login.dart';
import '../main/main.dart';

class SplashScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      MaterialPageRoute route;
      if (kUser != null) {
        route = MainScreen.route();
      } else {
        route = LoginScreen.route();
      }
      Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
