import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tasel_frontend/Widgets/scaffold_gradient.dart';
import 'package:tasel_frontend/theme/colors.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: BackButton(),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset('tasel.png')),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [Shadow.myShadow],
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Ionicons.mail_outline,
                              color: AppColors.yellow, size: 50),
                          const SizedBox(height: 8),
                          Text(
                            'Email Us',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'tasel@info.com',
                            style:
                                TextStyle(fontSize: 18, color: AppColors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [Shadow.myShadow],
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(
                            Ionicons.call_outline,
                            color: AppColors.yellow,
                            size: 50,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Call Us',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '0949879873',
                            style:
                                TextStyle(fontSize: 18, color: AppColors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Ionicons.logo_facebook),
                    color: AppColors.yellow,
                    iconSize: 40,
                    onPressed: () {
                      // Facebook
                    },
                  ),
                  IconButton(
                    icon: const Icon(Ionicons.logo_twitter),
                    color: AppColors.yellow,
                    iconSize: 40,
                    onPressed: () {
                      // Twitter
                    },
                  ),
                  IconButton(
                    icon: const Icon(Ionicons.logo_instagram),
                    color: AppColors.yellow,
                    iconSize: 40,
                    onPressed: () {
                      // Instagram
                    },
                  ),
                  IconButton(
                    icon: const Icon(Ionicons.logo_linkedin),
                    color: AppColors.yellow,
                    iconSize: 40,
                    onPressed: () {
                      //LinkedIn
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
