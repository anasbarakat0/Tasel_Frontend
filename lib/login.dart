import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasel_frontend/Model/login_model.dart';
import 'package:tasel_frontend/Widgets/my_button.dart';
import 'package:tasel_frontend/Widgets/my_text_field.dart';
import 'package:tasel_frontend/bloc/login_bloc.dart';
import 'package:tasel_frontend/bloc/login_provider_bloc.dart';
import 'package:tasel_frontend/signup_provider.dart';
import 'package:tasel_frontend/signup_user.dart';
import 'package:tasel_frontend/user_home_page.dart';
import '../../theme/colors.dart';
import 'forget_password.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

TextEditingController phoneOrEmail = TextEditingController();
TextEditingController password = TextEditingController();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = false;
  bool type = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('tasel.png', height: 120),
                  const Text(
                    'Welcome back!',
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                        fontSize: 35),
                  ),
                  const Text(
                    'Log in to your existant account',
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  LiteRollingSwitch(
                    value: type,
                    colorOn: AppColors.grey,
                    colorOff: AppColors.yellow,
                    textOn: 'Customer',
                    textOff: 'Provider',
                    textOnColor: Colors.white,
                    iconOn: Icons.person,
                    iconOff: Icons.store_mall_directory_sharp,
                    onTap: () {
                      type = !type;
                    },
                    onDoubleTap: () {
                      type = !type;
                    },
                    onSwipe: () {
                      type = !type;
                    },
                    onChanged: (type) {
                      print("the button is $type");
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyTextField(
                          controller: phoneOrEmail,
                          title: 'E-mail',
                          keyboardType: TextInputType.name,
                          prefixIcon: const Icon(Icons.person),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2.0,
                                  blurRadius: 5.0,
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: password,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide(
                                    color: AppColors.grey,
                                  ),
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: AppColors.lightGrey,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.darkYellow),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.grey[850],
                                prefixIcon: const Icon(Icons.lock),
                                prefixIconColor: AppColors.yellow,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              obscureText: !isPasswordVisible,
                              style: AppFont.textFieldStyle,
                              cursorColor: AppColors.yellow,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetPasswordPage(),
                                    ),
                                  );
                                },
                                child: Text('Forgot password?',
                                    style: AppFont.cairoS),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  type ? BUildUser() : BuildProvider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account ?",
                        style: TextStyle(fontFamily: 'Cairo', fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          if (type) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                            );
                          } else if (type == false) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpProvider(),
                              ),
                            );
                          }
                        },
                        child: Text('Sing Up', style: AppFont.cairoS),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

Widget BUildUser() {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) {
      switch (state) {
        case SuccessLogin():
          return Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            child: const Center(
              child: Text(
                "Success",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        case LoadingLogin():
          return const CircularProgressIndicator();

        case LoginInitial():
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Button(
                text: 'Log In',
                onPressed: () {
                  context.read<LoginBloc>().add(Signin(
                      user: LoginModel(
                          email: phoneOrEmail.text, password: password.text)));
                }),
          );

        case ErrorLogin():
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Button(
                text: 'Try Again',
                onPressed: () {
                  context.read<LoginBloc>().add(Signin(
                      user: LoginModel(
                          email: phoneOrEmail.text, password: password.text)));
                }),
          );
        case ExceptionLogin():
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Button(
                text: 'Try Again Later',
                onPressed: () {
                  context.read<LoginBloc>().add(Signin(
                      user: LoginModel(
                          email: phoneOrEmail.text, password: password.text)));
                }),
          );
        default:
          return const CircularProgressIndicator();
      }
    },
  );
}

Widget BuildProvider() {
  return BlocConsumer<LoginProviderBloc, LoginProviderState>(
    listener: (context, state) {
      if (state is SuccessLoginProvider) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserHomePage()));
      }
    },
    builder: (context, state) {
      switch (state) {
        case SuccessLoginProvider():
          return Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            child: const Center(
              child: Text(
                "Success",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        case LoadingLoginProvider():
          return const CircularProgressIndicator();

        case LoginProviderInitial():
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Button(
                text: 'Log In Provider',
                onPressed: () {
                  context.read<LoginProviderBloc>().add(SignedinProvider(
                      user: LoginModel(
                          email: phoneOrEmail.text, password: password.text)));
                }),
          );

        case ErrorLoginProvider():
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Button(
                text: 'Try Again',
                onPressed: () {
                  context.read<LoginProviderBloc>().add(SignedinProvider(
                      user: LoginModel(
                          email: phoneOrEmail.text, password: password.text)));
                }),
          );
        case ExceptionLoginProvider():
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Button(
                text: 'Try Again Later provider',
                onPressed: () {
                  context.read<LoginProviderBloc>().add(SignedinProvider(
                      user: LoginModel(
                          email: phoneOrEmail.text, password: password.text)));
                }),
          );
        default:
          return const CircularProgressIndicator();
      }
    },
  );
}
