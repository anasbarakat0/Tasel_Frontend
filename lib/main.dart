import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/spincircle_bottom_bar.dart';
import 'package:tasel_frontend/theme/colors.dart';

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
      navigator: HomePageProvider(
        tokenId: TokenModel(
          token:
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJvbkBnbWFpbC5jb20iLCJpYXQiOjE3MjAxMzcxMzl9.KGZHmD7ZE5oORUQNQBcvi-RyCXNyT1KH8zQtyDXC5JQ',
          id: '66851f574d49b75294fe793e',
        ),
      ),
      // navigator: HomePageUser(
      //   tokenId: TokenModel(
      //       id: '66851f574d49b75294fe793e',
      //       token:
      //           'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJvbkBnbWFpbC5jb20iLCJpYXQiOjE3MjAwMDAzNTV9.Wy7SjtrtM6q0VyTdkea05676qoX2fnbKDf7UdHymfdk'),
      // ),
      // navigator: SearchPage(),
      durationInSeconds: 1,
    );
  }
}
