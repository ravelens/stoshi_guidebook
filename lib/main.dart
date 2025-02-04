import 'package:flutter/material.dart';
import 'package:stoshi_guildbook/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            fontFamily: 'BSST',
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'BSST',
            color: Colors.white,
            fontSize: 20,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'BSST',
            color: Colors.white,
          ),
          titleSmall: TextStyle(fontFamily: 'BSST'),
          titleMedium: TextStyle(fontFamily: 'BSST'),
          titleLarge: TextStyle(fontFamily: 'BSST'),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
