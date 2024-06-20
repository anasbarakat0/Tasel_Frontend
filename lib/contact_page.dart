import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tasel_frontend/theme/colors.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: AppColors.yellow,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset('images/tasel.png')),
                    ),
                    const SizedBox(height: 50),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: AppColors.grey,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(Ionicons.mail_outline,
                                color: AppColors.yellow, size: 50),
                            const SizedBox(height: 8),
                            const Text(
                              'Email Us',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'tasel@info.com',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: AppColors.grey,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(Ionicons.call_outline,
                                color: AppColors.yellow, size: 50),
                            const SizedBox(height: 8),
                            const Text(
                              'Call Us',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '0949879873',
                              style: TextStyle(
                                fontSize: 18,
                              ),
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
                        // Handle Facebook button press
                      },
                    ),
                    IconButton(
                      icon: const Icon(Ionicons.logo_twitter),
                      color: AppColors.yellow,
                      iconSize: 40,
                      onPressed: () {
                        // Handle Twitter button press
                      },
                    ),
                    IconButton(
                      icon: const Icon(Ionicons.logo_instagram),
                      color: AppColors.yellow,
                      iconSize: 40,
                      onPressed: () {
                        // Handle Instagram button press
                      },
                    ),
                    IconButton(
                      icon: const Icon(Ionicons.logo_linkedin),
                      color: AppColors.yellow,
                      iconSize: 40,
                      onPressed: () {
                        // Handle LinkedIn button press
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
