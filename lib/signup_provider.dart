import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tasel_frontend/Model/signup_provider_model.dart';
import 'package:tasel_frontend/Widgets/my_button.dart';
import 'package:tasel_frontend/Widgets/my_text_field.dart';
import 'package:tasel_frontend/bloc/signup_provider_bloc.dart';
import '../../theme/colors.dart';
import 'login.dart';
import 'package:validators/validators.dart';

class SignUpProvider extends StatefulWidget {
  const SignUpProvider({super.key});

  @override
  State<SignUpProvider> createState() => _SignUpProviderState();
}

class _SignUpProviderState extends State<SignUpProvider> {
  final TextEditingController providerController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController landlineNumberController =
      TextEditingController();
  final TextEditingController websiteUrlController = TextEditingController();
  final TextEditingController websiteTitleController = TextEditingController();
  final TextEditingController instagramUrlController = TextEditingController();
  final TextEditingController instagramUsernameController =
      TextEditingController();
  final TextEditingController facebookUrlController = TextEditingController();
  final TextEditingController facebookUsernameController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conPasswordController = TextEditingController();

  String mobile = '';
  bool isEmailCorrect = false;
  bool isPasswordVisible = false;
  bool isCPasswordVisible = false;
  bool match = false;

  bool isNumber(String str) {
    final numericRegex = RegExp(r'^-?[0-9]+$');
    return numericRegex.hasMatch(str);
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  late SignupProviderModel provider;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupProviderBloc(),
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
                      'Do you want to join us as a Provider?',
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
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            //Provider-Name
                            MyTextField(
                              controller: providerController,
                              title: 'Provider-Name',
                              keyboardType: TextInputType.name,
                              prefixIcon: const Icon(Icons.person),
                            ),

                            //E-Mail
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
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
                                          Radius.circular(50),
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
                                        borderSide: BorderSide(
                                            color: AppColors.darkYellow),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                      ),
                                      fillColor: Colors.grey[850],
                                      filled: true),
                                  cursorColor: AppColors.darkYellow,
                                  onTap: () {
                                    if (providerController.text.length < 4) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "User Name Can't Be Less Than 4 characters")),
                                      );
                                      return;
                                    }
                                  },
                                ),
                              ),
                            ),

                            //Phone Number
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
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
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                        borderSide: BorderSide(
                                          color: AppColors.grey,
                                        ),
                                      ),
                                      hintText: 'Mobile Number',
                                      counterText: '',
                                      hintStyle: TextStyle(
                                        color: AppColors.lightGrey,
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.darkYellow),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                      ),
                                      fillColor: Colors.grey[850],
                                      filled: true),
                                  initialCountryCode: 'SY',
                                  cursorColor: AppColors.darkYellow,
                                  onChanged: (phone) {
                                    mobile = phone.completeNumber;
                                  },
                                  pickerDialogStyle: PickerDialogStyle(
                                    backgroundColor: Colors.grey[850],
                                  ),
                                  onTap: () {
                                    if (!isEmailCorrect) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Email is not correct")),
                                      );
                                      return;
                                    }
                                  },
                                ),
                              ),
                            ),

                            //Landline Phone Number
                            MyTextField(
                              controller: landlineNumberController,
                              title: 'Landline Phone Number',
                              keyboardType: TextInputType.phone,
                              prefixIcon: const Icon(Icons.phone),
                              maxLength: 7,
                              ontap: () {
                                if (phoneNumController.text.startsWith('0')) {
                                  mobile = mobile.substring(0, 4) +
                                      mobile.substring(5);
                                }
                                if (phoneNumController.text.length < 10 ||
                                    !isNumber(phoneNumController.text)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Invalid Mobile Number $mobile")),
                                  );
                                  return;
                                }
                              },
                            ),

                            //Website
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: MyTextField(
                                    controller: websiteUrlController,
                                    title: 'Website URL*',
                                    keyboardType: TextInputType.url,
                                    prefixIcon: const Icon(Icons.link),
                                    ontap: () {
                                      if (landlineNumberController
                                                  .text.length !=
                                              7 ||
                                          !isNumber(
                                              landlineNumberController.text)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Invalid Landline Phone Number ${landlineNumberController.text}")),
                                        );
                                        return;
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: MyTextField(
                                    controller: websiteTitleController,
                                    title: 'Website Title*',
                                    keyboardType: TextInputType.name,
                                    ontap: () {
                                      if (websiteUrlController.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  "Can't Enter the title of your Website Without Enternig the Website URL")),
                                        );
                                        return;
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),

                            //Instagram
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: MyTextField(
                                    controller: instagramUrlController,
                                    title: 'Account URL*',
                                    keyboardType: TextInputType.url,
                                    prefixIcon:
                                        const Icon(Ionicons.logo_instagram),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: MyTextField(
                                    controller: instagramUsernameController,
                                    title: 'Username*',
                                    keyboardType: TextInputType.name,
                                    ontap: () {
                                      if (instagramUrlController.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  "Can't Enter Instagram Username Without Enternig the URL of this Account")),
                                        );
                                        return;
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),

                            //Facebook
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: MyTextField(
                                    controller: facebookUrlController,
                                    title: 'Account URL*',
                                    keyboardType: TextInputType.url,
                                    prefixIcon:
                                        const Icon(Ionicons.logo_facebook),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: MyTextField(
                                    controller: facebookUsernameController,
                                    title: 'Username*',
                                    keyboardType: TextInputType.name,
                                    ontap: () {
                                      if (instagramUrlController.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  "Can't Enter Facebook Username Without Enternig the URL of this Account")),
                                        );
                                        return;
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),

                            //Password
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
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
                                        Radius.circular(50),
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
                                      borderSide: BorderSide(
                                          color: AppColors.darkYellow),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(50),
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
                                          isPasswordVisible =
                                              !isPasswordVisible;
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

                            //ConfirmPassword
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
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
                                        Radius.circular(50),
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
                                        isCPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isCPasswordVisible =
                                              !isCPasswordVisible;
                                        });
                                      },
                                    ),
                                    focusedBorder: match
                                        ? const OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(50),
                                            ),
                                            borderSide: BorderSide(
                                                color: Colors.green,
                                                width: 1.0),
                                          )
                                        : OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(50),
                                            ),
                                            borderSide: BorderSide(
                                                color: AppColors.yellow,
                                                width: 1.0),
                                          ),
                                    fillColor: Colors.grey[850],
                                    filled: true,
                                  ),
                                  obscureText: !isCPasswordVisible,
                                  style: AppFont.textFieldStyle,
                                  cursorColor: AppColors.yellow,
                                  onSubmitted: (_) {
                                    //todo _signInButtonPressed();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Sign Up Button
                      BlocBuilder<SignupProviderBloc, SignupProviderState>(
                        builder: (context, state) {
                          switch (state) {
                            case SignupProviderInitial():
                              return Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: Button(
                                    text: 'Sign Up',
                                    onPressed: () async {
                                      if (providerController.text.isEmpty ||
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

                                      if (providerController.text.length < 4) {
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

                                      if (phoneNumController.text.length < 10 ||
                                          !isNumber(phoneNumController.text)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Invalid Mobile Number $mobile")),
                                        );
                                        return;
                                      }

                                      if (websiteUrlController.text.isEmpty &&
                                          websiteTitleController
                                              .text.isNotEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  "Can't Enter the title of your Website Without Enternig the Website URL")),
                                        );
                                        return;
                                      }

                                      if (instagramUrlController
                                              .text.isNotEmpty &&
                                          instagramUsernameController
                                              .text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  "Please Enter the Username of Your Instagram Account")),
                                        );
                                        return;
                                      }

                                      if (facebookUrlController
                                              .text.isNotEmpty &&
                                          facebookUsernameController
                                              .text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  "Please Enter the Username of Your Facebook Account")),
                                        );
                                        return;
                                      }

                                      if (instagramUsernameController
                                              .text.isNotEmpty &&
                                          instagramUrlController.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  "Can't Enter Instagram Username Without Enternig the URL of this Account")),
                                        );
                                        return;
                                      }

                                      if (facebookUsernameController
                                              .text.isNotEmpty &&
                                          facebookUrlController.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  "Can't Enter Facebook Username Without Enternig the URL of this Account")),
                                        );
                                        return;
                                      }

                                      if (passwordController.text ==
                                          conPasswordController.text) {
                                        //todo: signup provider methode

                                        context
                                            .read<SignupProviderBloc>()
                                            .add(SignedupProvider(
                                              provider: SignupProviderModel(
                                                  name: providerController.text,
                                                  latitude: 'latitude',
                                                  longitude: 'longitude',
                                                  phoneNumbers:
                                                      phoneNumController.text,
                                                  landlines:
                                                      landlineNumberController
                                                          .text,
                                                  address: 'address',
                                                  email: emailController.text,
                                                  whatsappNumber:
                                                      'whatsappNumber',
                                                  instagramAccount:
                                                      instagramUrlController
                                                          .text,
                                                  instagramUsername:
                                                      instagramUsernameController
                                                          .text,
                                                  facebookPage:
                                                      facebookUrlController
                                                          .text,
                                                  facebookUsername:
                                                      facebookUsernameController
                                                          .text,
                                                  category: 'category',
                                                  password:
                                                      passwordController.text),
                                            ));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Please reconfirm your password")));
                                      }
                                    },
                                  ));
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
                              return Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Button(
                                    text: 'Try Again',
                                    onPressed: () {
                                      context.read<SignupProviderBloc>().add(
                                            SignedupProvider(
                                              provider: SignupProviderModel(
                                                  name: providerController.text,
                                                  latitude: 'latitude',
                                                  longitude: 'longitude',
                                                  phoneNumbers:
                                                      phoneNumController.text,
                                                  landlines:
                                                      landlineNumberController
                                                          .text,
                                                  address: 'address',
                                                  email: emailController.text,
                                                  whatsappNumber:
                                                      'whatsappNumber',
                                                  instagramAccount:
                                                      instagramUrlController
                                                          .text,
                                                  instagramUsername:
                                                      instagramUsernameController
                                                          .text,
                                                  facebookPage:
                                                      facebookUrlController
                                                          .text,
                                                  facebookUsername:
                                                      facebookUsernameController
                                                          .text,
                                                  category: 'category',
                                                  password:
                                                      passwordController.text),
                                            ),
                                          );
                                    }),
                              );
                            case Exception():
                              return Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Button(
                                    text: 'Try Again Later',
                                    onPressed: () {
                                      context.read<SignupProviderBloc>().add(
                                            SignedupProvider(
                                              provider: SignupProviderModel(
                                                  name: providerController.text,
                                                  latitude: 'latitude',
                                                  longitude: 'longitude',
                                                  phoneNumbers:
                                                      phoneNumController.text,
                                                  landlines:
                                                      landlineNumberController
                                                          .text,
                                                  address: 'address',
                                                  email: emailController.text,
                                                  whatsappNumber:
                                                      'whatsappNumber',
                                                  instagramAccount:
                                                      instagramUrlController
                                                          .text,
                                                  instagramUsername:
                                                      instagramUsernameController
                                                          .text,
                                                  facebookPage:
                                                      facebookUrlController
                                                          .text,
                                                  facebookUsername:
                                                      facebookUsernameController
                                                          .text,
                                                  category: 'category',
                                                  password:
                                                      passwordController.text),
                                            ),
                                          );
                                    }),
                              );
                            case Loading():
                              return CircularProgressIndicator();
                            default:
                              return CircularProgressIndicator();
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
