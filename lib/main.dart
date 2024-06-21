import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tasel_frontend/login.dart';
import 'package:tasel_frontend/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

String baseurl = 'https://tasel-backend-g6gsdfug6a-uc.a.run.app';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasel Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.yellow),
        primaryColorDark: AppColors.yellow,
        textTheme: ThemeData.dark(useMaterial3: true).textTheme.copyWith(
              bodyLarge: const TextStyle(
                fontFamily: 'Cairo',
              ),
            ),
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.yellow),
        fontFamily: 'Cairo',
        useMaterial3: true,
        primaryColorDark: AppColors.yellow,
      ),
      home: const LoginPage(),
    );
  }
}
