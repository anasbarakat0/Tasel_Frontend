import 'package:flutter/material.dart';
import 'package:tasel_frontend/theme/colors.dart';
import 'package:tasel_frontend/user_home_page.dart';

void main() {
  runApp(const MyApp());
}

String baseurl = 'http://localhost:4003';

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
      home: UserHomePage(),
      // ProviderHomePage(
      //   providerInfo: ProviderInfo(
      //     address: Address(
      //         areaName: 'areaName',
      //         streetName: 'streetName',
      //         buildingNameorNumber: 'buildingNameorNumber',
      //         floor: 'floor'),
      //     profileImage:
      //         'https://www.bing.com/images/search?view=detailV2&ccid=OLJB7RoR&id=B7F2D3738EA90925DB48D68D38034B249A3416B0&thid=OIP.OLJB7RoRAaXgM2pnHKPsogHaFC&mediaurl=https%3a%2f%2flogos-download.com%2fwp-content%2fuploads%2f2016%2f03%2fMcDonalds_Logo_1968.png&cdnurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.38b241ed1a1101a5e0336a671ca3eca2%3frik%3dsBY0miRLAziN1g%26pid%3dImgRaw%26r%3d0&exph=3402&expw=5000&q=mcdonald%27s+logo&simid=607990365711305299&FORM=IRPRST&ck=48400423D13E85083CA39C516578AE5A&selectedIndex=5&itb=1',
      //     name: 'name',
      //     longitude: 1234,
      //     latitude: 1234,
      //     phoneNumbers: [0927823],
      //     landlines: [8374829839],
      //     whatsappNumber: 647382392,
      //     category: 'category',
      //     email: 'email',
      //     facebookPage: 'https://www.facebook.com',
      //     facebookUsername: 'facebookUsername',
      //     instagramAccount: 'instagramAccount',
      //     instagramUsername: 'instagramUsername',
      //   ),
      // ),
    );
  }
}
