import 'package:flutter/material.dart';
import 'package:manager_app/init_hive.dart';
import 'package:manager_app/src/screens/splash/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manager App',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const SplashScreen(),
    );
  }
}
