import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tasel_frontend/Model/provider_info.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/Widgets/my_text_field.dart';
import 'package:tasel_frontend/service/update_provider.dart';
import 'package:tasel_frontend/theme/colors.dart';

class ProviderUpdateInfoPage extends StatefulWidget {
  final TokenModel tokenId;
  const ProviderUpdateInfoPage({super.key, required this.tokenId});

  @override
  _ProviderUpdateInfoPageState createState() => _ProviderUpdateInfoPageState();
}

class _ProviderUpdateInfoPageState extends State<ProviderUpdateInfoPage> {
  late TextEditingController name;
  late TextEditingController phoneNumber;
  late TextEditingController landlines;
  late TextEditingController whatsappNumber;
  late TextEditingController category;
  late TextEditingController facebookPage;
  late TextEditingController instagramAccount;
  late TextEditingController websiteUrl;
  late TextEditingController email;
  late TextEditingController areaName;
  late TextEditingController streetName;
  late TextEditingController buildingNameorNumber;
  late TextEditingController floor;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: 'name');
    phoneNumber = TextEditingController(text: 'phoneNumber');
    landlines = TextEditingController(text: 'landlines');
    whatsappNumber = TextEditingController(text: 'whatsappNumber');
    category = TextEditingController(text: 'category');
    facebookPage = TextEditingController(text: 'facebookPage');
    instagramAccount = TextEditingController(text: 'instagramAccount');
    websiteUrl = TextEditingController(text: 'websiteUrl');
    email = TextEditingController(text: 'email');
    areaName = TextEditingController(text: 'areaName');
    streetName = TextEditingController(text: 'streetName');
    buildingNameorNumber = TextEditingController(text: 'buildingNameorNumber');
    floor = TextEditingController(text: 'floor');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tasel',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.yellow,
        foregroundColor: AppColors.grey,
        centerTitle: true,
      ),
      drawerEnableOpenDragGesture: true,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          var edit = await updateProvider(
              widget.tokenId,
              ProviderInfo(
                  address: Address(
                      areaName: areaName.text,
                      streetName: streetName.text,
                      buildingNameorNumber: buildingNameorNumber.text,
                      floor: floor.text),
                  profileImage: 'profileImage',
                  name: name.text,
                  longitude: 0.0,
                  latitude: 0.0,
                  phoneNumbers: phoneNumber.text
                      .split(',')
                      .map((e) => int.parse(e.trim()))
                      .toList(),
                  landlines: landlines.text
                      .split(',')
                      .map((e) => int.parse(e.trim()))
                      .toList(),
                  whatsappNumber: int.parse(whatsappNumber.text),
                  category: category.text,
                  email: email.text,
                  facebookPage: facebookPage.text,
                  facebookUsername: '',
                  instagramAccount: instagramAccount.text,
                  instagramUsername: '',
                  websiteUrl: websiteUrl.text));
          if (edit) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Your data has been changed")),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Error, Try again later")),
            );
          }
        },
        icon: const Icon(Icons.save),
        label: const Text('Save changes'),
        backgroundColor: AppColors.yellow,
        foregroundColor: AppColors.grey,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                const Text(
                  'Your Info...',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                MyTextField(
                  controller: name,
                  title: 'Name',
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(Icons.person),
                  ontap: (p0) {},
                ),
                MyTextField(
                  controller: phoneNumber,
                  title: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone),
                  ontap: (p0) {},
                ),
                MyTextField(
                  controller: landlines,
                  title: 'landlines',
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Ionicons.phone_landscape),
                  ontap: (p0) {},
                ),
                MyTextField(
                  controller: whatsappNumber,
                  title: 'Whatsapp Number',
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Ionicons.logo_whatsapp),
                  ontap: (p0) {},
                ),
                MyTextField(
                  controller: category,
                  title: 'Category',
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(Icons.category),
                  ontap: (p0) {},
                ),
                MyTextField(
                  controller: facebookPage,
                  title: 'Facebook URL',
                  keyboardType: TextInputType.url,
                  prefixIcon: const Icon(Ionicons.logo_facebook),
                  ontap: (p0) {},
                ),
                MyTextField(
                  controller: instagramAccount,
                  title: 'Instagram URL',
                  keyboardType: TextInputType.url,
                  prefixIcon: const Icon(Ionicons.logo_instagram),
                  ontap: (p0) {},
                ),
                MyTextField(
                  controller: websiteUrl,
                  title: 'Website URL',
                  keyboardType: TextInputType.url,
                  prefixIcon: const Icon(Icons.link),
                  ontap: (p0) {},
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
                      style: AppFont.textFieldStyle,
                      controller: email,
                      readOnly: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: AppColors.grey,
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: AppColors.lightGrey,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                        alignLabelWithHint: true,
                        prefixIcon: const Icon(Icons.email_outlined),
                        prefixIconColor: AppColors.yellow,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.darkYellow),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        fillColor: Colors.grey[850],
                        filled: true,
                        counterText: '',
                      ),
                      textAlign: TextAlign.start,
                      cursorColor: AppColors.darkYellow,
                    ),
                  ),
                ),
                MyTextField(
                  controller: areaName,
                  title: 'areaName',
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(Icons.location_searching),
                  ontap: (p0) {},
                ),
                MyTextField(
                  controller: streetName,
                  title: 'streetName',
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(Icons.edit_road_rounded),
                  ontap: (p0) {},
                ),
                MyTextField(
                  controller: buildingNameorNumber,
                  title: 'buildingNameorNumber',
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(Icons.location_city_outlined),
                  ontap: (p0) {},
                ),
                MyTextField(
                  controller: floor,
                  title: 'floor',
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(Icons.stairs),
                  ontap: (p0) {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
