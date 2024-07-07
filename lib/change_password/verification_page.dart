import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:tasel_frontend/Widgets/scaffold_gradient.dart';
import 'package:tasel_frontend/change_password/change_password_page.dart';
import 'package:tasel_frontend/change_password/services.dart';
import '../../../theme/colors.dart';
import 'forget_password.dart';

class VerificationPage extends StatefulWidget {
  final TextEditingController nameController;
  final String email;
  const VerificationPage({
    super.key,
    required this.nameController,
    required this.email,
  });

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

// ignore: camel_case_types
class _VerificationPageState extends State<VerificationPage> {
  void updateButtonState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: TextStyle(
        fontSize: 22,
        color: AppColors.darkYellow,
      ),
      decoration: BoxDecoration(
        boxShadow: [Shadow.myShadow],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.lightGrey,
          width: 1,
        ),
      ),
    );
    return GradientScaffold(
      body: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgetPasswordPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.keyboard_backspace_sharp),
              ),
            ),
            Container(
              height: 200,
              alignment: Alignment.center,
              child: const Text(
                'Verification Page',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                "Please Enter your verification code",
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                widget.nameController.text,
                style: TextStyle(
                  color: AppColors.lightGrey,
                  fontFamily: 'Cairo',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Pinput(
              length: 4,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border.all(color: AppColors.grey),
                ),
              ),
              onCompleted: (pin) async {
                if (/*widget.code == pin*/ true) {
                  var status = await changePassword(
                      widget.email, pin, widget.nameController.text);

                  if (/*status[0] ==*/ true) {
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePasswordPage(
                                email: widget.email,
                                nameController: widget.nameController,
                                code: pin,
                              )),
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("$status")));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("The verification code is incorrect")));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
