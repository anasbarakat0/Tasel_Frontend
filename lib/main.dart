import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/login.dart';
import 'package:tasel_frontend/spincircle_bottom_bar.dart';
import 'package:tasel_frontend/theme/colors.dart';
import 'package:tasel_frontend/user/curved_navigation_bar.dart';

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
      themeMode: ThemeMode.light,
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
        scaffoldBackgroundColor: Colors.white,
        dialogBackgroundColor: AppColors.grey,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.yellow),
        fontFamily: 'Cairo',
        useMaterial3: true,
        primaryColorDark: AppColors.yellow,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
        'tasel.png',
        height: 150,
      ),
      backgroundColor: Colors.white,
      showLoader: true,
      logoWidth: 200.0,
      loaderColor: AppColors.yellow,
      title: Text(
        'Tasel',
        style: TextStyle(
          fontSize: 35,
          color: AppColors.yellow,
          fontWeight: FontWeight.w900,
        ),
      ),
      // navigator: HomePageProvider(
      //   tokenId: TokenModel(
      //     token:
      //         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImdyYXBoQGdtYWlsLmNvbSIsImlhdCI6MTcyMDMwMzU4NH0.GsM5rs8tM4z1COO0c5qBtz4ejDGNHvreM8esVsT8BOM',
      //     id: '66857bfd206a850c2859d56c',
      //   ),
      // ),
      navigator: HomePageUser(
        tokenId: TokenModel(
            id: '66752622900a3e935505dc62',
            token:
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MjAzNDA1ODl9.mjOlCpKbtA6oSYgF6FC3zPBPTBawc9nezBRETHpamZ4'),
      ),
      // navigator: LoginPage(),
      durationInSeconds: 1,
    );
  }
}
