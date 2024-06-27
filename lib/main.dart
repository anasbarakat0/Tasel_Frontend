import 'package:flutter/material.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/login.dart';
import 'package:tasel_frontend/theme/colors.dart';
import 'package:tasel_frontend/user_home_page.dart';

void main() {
  runApp(const MyApp());
}

String baseurl = 'https://tasel-backend-g6gsdfug6a-uc.a.run.app';
// String baseurl = 'http://localhost:8080';
String tokenS = '';
String userIdS = '';
bool isAuth = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      home: isAuth
          ? UserHomePage(
              tokenId: TokenModel(
                token: tokenS,
                id: userIdS,
              ),
            )
          : const LoginPage(),
    );
  }
}
