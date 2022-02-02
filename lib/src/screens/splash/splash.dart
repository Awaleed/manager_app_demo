import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/src/screens/auth/login.dart';
import 'package:manager_app/src/screens/auth/register.dart';
import 'package:manager_app/src/screens/main/main.dart';

import 'cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          MaterialPageRoute route;
          switch (state) {
            case SplashState.authenticated:
              route = MainScreen.route();
              break;
            case SplashState.unauthenticated:
              route = LoginScreen.route();
              break;
            case SplashState.loading:
              return;
          }
          Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
        },
        child: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
