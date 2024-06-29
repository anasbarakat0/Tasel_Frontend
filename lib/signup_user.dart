import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tasel_frontend/Model/signup_user_model.dart';
import 'package:tasel_frontend/Widgets/my_button.dart';
import 'package:tasel_frontend/Widgets/my_text_field.dart';
import 'package:tasel_frontend/bloc/signup_user_bloc.dart';
import 'package:validators/validators.dart';
import '../../theme/colors.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController phoneNumController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController conPasswordController = TextEditingController();

  bool isEmailCorrect = false;
  bool isPasswordVisible = false;
  bool isCPasswordVisible = false;
  bool match = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupUserBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: ListView(
                padding: const EdgeInsets.all(7),
                shrinkWrap: false,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      icon: const Icon(Icons.keyboard_backspace_sharp),
                    ),
                  ),
                  Container(
                    height: 80,
                    alignment: Alignment.bottomLeft,
                    child: const Text(
                      'Do you want to join us as a User?',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "So, welcome... Register here",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      MyTextField(
                        ontap: (p0) {},
                        controller: _nameController,
                        title: 'UserName',
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
                            keyboardType: TextInputType.emailAddress,
                            style: AppFont.textFieldStyle,
                            controller: emailController,
                            onChanged: (val) {
                              setState(() {
                                isEmailCorrect = isEmail(val);
                              });
                            },
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide(
                                    color: AppColors.grey,
                                  ),
                                ),
                                hintText: 'E-mail',
                                hintStyle: TextStyle(
                                  color: AppColors.lightGrey,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                                prefixIcon: const Icon(Icons.email),
                                prefixIconColor: AppColors.yellow,
                                suffixIcon: isEmailCorrect == false
                                    ? null
                                    : const Icon(
                                        Icons.done,
                                        color: Colors.green,
                                      ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.darkYellow),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                fillColor: Colors.grey[850],
                                filled: true),
                            cursorColor: AppColors.darkYellow,
                          ),
                        ),
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
                          child: IntlPhoneField(
                            showCountryFlag: false,
                            style: AppFont.textFieldStyle,
                            controller: phoneNumController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.grey,
                                ),
                              ),
                              hintText: 'Phone Number',
                              counterText: '',
                              hintStyle: TextStyle(
                                color: AppColors.lightGrey,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.darkYellow,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              fillColor: Colors.grey[850],
                              filled: true,
                            ),
                            initialCountryCode: 'SY',
                            cursorColor: AppColors.darkYellow,
                          ),
                        ),
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
                            controller: passwordController,
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
                              fillColor: Colors.grey[850],
                              filled: true,
                            ),
                            obscureText: !isPasswordVisible,
                            style: AppFont.textFieldStyle,
                            cursorColor: AppColors.yellow,
                            onSubmitted: (_) {
                              //todo _signInButtonPressed();
                            },
                          ),
                        ),
                      ),
                      //////////////////////////////////*
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
                            onChanged: (value) {
                              setState(() {
                                if (value == passwordController.text) {
                                  match = true;
                                } else {
                                  match = false;
                                }
                              });
                            },
                            controller: conPasswordController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.grey,
                                ),
                              ),
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(
                                color: AppColors.lightGrey,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
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
                              focusedBorder: match
                                  ? const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      borderSide: BorderSide(
                                          color: Colors.green, width: 1.0),
                                    )
                                  : OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      borderSide: BorderSide(
                                          color: AppColors.yellow, width: 1.0),
                                    ),
                              fillColor: Colors.grey[850],
                              filled: true,
                            ),
                            obscureText: !isPasswordVisible,
                            style: AppFont.textFieldStyle,
                            cursorColor: AppColors.yellow,
                            onSubmitted: (_) {
                              //todo _signInButtonPressed();
                            },
                          ),
                        ),
                      ),
                      BlocConsumer<SignupUserBloc, SignupUserState>(
                        listener: (context, state) {
                          if (state is Success) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          }
                        },
                        builder: (context, state) {
                          switch (state) {
                            case SignupUserInitial():
                              return Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Button(
                                  text: 'Sign Up',
                                  onPressed: () async {
                                    if (_nameController.text.isEmpty ||
                                        phoneNumController.text.isEmpty ||
                                        emailController.text.isEmpty ||
                                        passwordController.text.isEmpty ||
                                        conPasswordController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Please fill in all fields")),
                                      );
                                      return;
                                    }
                                    if (_nameController.text.length < 4) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "User Name Can't Be Less Than 4 characters")),
                                      );
                                      return;
                                    }
                                    if (!isEmailCorrect) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Email is not correct")),
                                      );
                                      return;
                                    }

                                    if (phoneNumController.text.length < 9) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Invalid Mobile Number")),
                                      );
                                      return;
                                    }

                                    if (passwordController.text ==
                                        conPasswordController.text) {
                                      context.read<SignupUserBloc>().add(
                                          SignupUser(
                                              user: UserModel(
                                                  name: _nameController.text,
                                                  phone:
                                                      phoneNumController.text,
                                                  email: emailController.text,
                                                  address: 'address',
                                                  latitude: 'latitude',
                                                  longitude: 'longitude',
                                                  password: passwordController
                                                      .text)));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Please reconfirm your password")));
                                    }
                                  },
                                ),
                              );

                            case Success():
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
                            case Error():
                              return Center(
                                child: Column(
                                  children: [
                                    Text(state.message),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40),
                                      child: Button(
                                        text: 'Sign Up',
                                        onPressed: () async {
                                          if (_nameController.text.isEmpty ||
                                              phoneNumController.text.isEmpty ||
                                              emailController.text.isEmpty ||
                                              passwordController.text.isEmpty ||
                                              conPasswordController
                                                  .text.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      "Please fill in all fields")),
                                            );
                                            return;
                                          }
                                          if (_nameController.text.length < 4) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      "User Name Can't Be Less Than 4 characters")),
                                            );
                                            return;
                                          }
                                          if (!isEmailCorrect) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      "Email is not correct")),
                                            );
                                            return;
                                          }

                                          if (phoneNumController.text.length <
                                              9) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      "Invalid Mobile Number")),
                                            );
                                            return;
                                          }

                                          if (passwordController.text ==
                                              conPasswordController.text) {
                                            context.read<SignupUserBloc>().add(
                                                SignupUser(
                                                    user: UserModel(
                                                        name: _nameController
                                                            .text,
                                                        phone:
                                                            phoneNumController
                                                                .text,
                                                        email: emailController
                                                            .text,
                                                        address: 'address',
                                                        latitude: 'latitude',
                                                        longitude: 'longitude',
                                                        password:
                                                            passwordController
                                                                .text)));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Please reconfirm your password")));
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              );

                            case Exception():
                              return Center(
                                child: Column(
                                  children: [
                                    Text(state.message),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40),
                                      child: Button(
                                        text: 'Sign Up',
                                        onPressed: () async {
                                          if (_nameController.text.isEmpty ||
                                              phoneNumController.text.isEmpty ||
                                              emailController.text.isEmpty ||
                                              passwordController.text.isEmpty ||
                                              conPasswordController
                                                  .text.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      "Please fill in all fields")),
                                            );
                                            return;
                                          }
                                          if (_nameController.text.length < 4) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      "User Name Can't Be Less Than 4 characters")),
                                            );
                                            return;
                                          }
                                          if (!isEmailCorrect) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      "Email is not correct")),
                                            );
                                            return;
                                          }

                                          if (phoneNumController.text.length <
                                              9) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      "Invalid Mobile Number")),
                                            );
                                            return;
                                          }

                                          if (passwordController.text ==
                                              conPasswordController.text) {
                                            context.read<SignupUserBloc>().add(
                                                SignupUser(
                                                    user: UserModel(
                                                        name: _nameController
                                                            .text,
                                                        phone:
                                                            phoneNumController
                                                                .text,
                                                        email: emailController
                                                            .text,
                                                        address: 'address',
                                                        latitude: 'latitude',
                                                        longitude: 'longitude',
                                                        password:
                                                            passwordController
                                                                .text)));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Please reconfirm your password")));
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              );

                            case Loading():
                              return const CircularProgressIndicator();

                            default:
                              return const CircularProgressIndicator();
                          }
                        },
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
