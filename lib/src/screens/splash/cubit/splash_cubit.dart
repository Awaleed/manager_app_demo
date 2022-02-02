import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:manager_app/src/repositories/users_repository.dart';

enum SplashState { loading, authenticated, unauthenticated }

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.loading) {
    Timer.run(() {
      if (kUser != null) {
        emit(SplashState.authenticated);
      } else {
        emit(SplashState.unauthenticated);
      }
    });
  }
}
