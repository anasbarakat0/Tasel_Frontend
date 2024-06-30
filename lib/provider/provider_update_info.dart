import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tasel_frontend/Model/provider_info.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/Widgets/my_text_field.dart';
import 'package:tasel_frontend/bloc/provider_info_bloc.dart';
import 'package:tasel_frontend/service/update_provider.dart';
import 'package:tasel_frontend/theme/colors.dart';

class ProviderUpdateInfoPage extends StatefulWidget {
  final TokenModel tokenId;
  const ProviderUpdateInfoPage({super.key, required this.tokenId});

  @override
  // ignore: library_private_types_in_public_api
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

  String mobile = '';
  bool isEmailCorrect = false;

  bool disable = false;

  bool isNumber(String str) {
    final numericRegex = RegExp(r'^-?[0-9]+$');
    return numericRegex.hasMatch(str);
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    phoneNumber = TextEditingController();
    landlines = TextEditingController();
    whatsappNumber = TextEditingController();
    category = TextEditingController();
    facebookPage = TextEditingController();
    instagramAccount = TextEditingController();
    websiteUrl = TextEditingController();
    email = TextEditingController();
    areaName = TextEditingController();
    streetName = TextEditingController();
    buildingNameorNumber = TextEditingController();
    floor = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProviderInfoBloc(),
      child: Builder(builder: (context) {
        context
            .read<ProviderInfoBloc>()
            .add(ShowProviderInfo(idProvider: widget.tokenId.id));
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
              if (disable) {
                ProviderInfo provider = ProviderInfo(
                    address: Address(
                        areaName: areaName.text,
                        streetName: streetName.text,
                        buildingNameorNumber: buildingNameorNumber.text,
                        floor: floor.text),
                    profileImage: '',
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
                    websiteUrl: websiteUrl.text);
                var edit = await updateProvider(widget.tokenId, provider);

                if (edit) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Your data has been changed"),
                        backgroundColor: Colors.green),
                  );
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Error, Try again later")),
                  );
                }
              } else {}
            },
            icon: const Icon(Icons.save),
            label: const Text('Save changes'),
            backgroundColor: disable ? AppColors.yellow : AppColors.grey,
            foregroundColor: disable ? AppColors.grey : AppColors.lightGrey,
          ),
          body: BlocListener<ProviderInfoBloc, ProviderInfoState>(
            listener: (context, state) {
              if (state is SuccessShowProviderInfo) {
                if (!disable) {
                  name.text = state.provider.name;
                  phoneNumber.text = state.provider.phoneNumbers.join(', ');
                  landlines.text = state.provider.landlines.join(', ');
                  whatsappNumber.text =
                      state.provider.whatsappNumber.toString();
                  category.text = state.provider.category;
                  facebookPage.text = state.provider.facebookPage;
                  instagramAccount.text = state.provider.instagramAccount;
                  websiteUrl.text = state.provider.websiteUrl;
                  email.text = state.provider.email;
                  areaName.text = state.provider.address.areaName;
                  streetName.text = state.provider.address.streetName;
                  buildingNameorNumber.text =
                      state.provider.address.buildingNameorNumber;
                  floor.text = state.provider.address.floor;
                }
                setState(() {
                  disable = true;
                });
              }
            },
            child: BlocBuilder<ProviderInfoBloc, ProviderInfoState>(
              builder: (context, state) {
                if (state is SuccessShowProviderInfo) {
                  return SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(
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
                            const SizedBox(
                              height: 25,
                            ),
                            MyTextField(
                              controller: name,
                              title: 'Name',
                              keyboardType: TextInputType.name,
                              prefixIcon: const Icon(Icons.person),
                              ontap: (p0) {},
                            ),
                            IntlPhoneField(
                              showCountryFlag: false,
                              style: AppFont.textFieldStyle,
                              controller: phoneNumber,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
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
                                    borderSide:
                                        BorderSide(color: AppColors.darkYellow),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
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
                              onTap: () {},
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            MyTextField(
                              controller: landlines,
                              title: 'Landline Phone Number',
                              keyboardType: TextInputType.phone,
                              prefixIcon: const Icon(Icons.phone),
                              maxLength: 7,
                              ontap: (val) {
                                if (phoneNumber.text.startsWith('0')) {
                                  mobile = mobile.substring(0, 4) +
                                      mobile.substring(5);
                                } else if (phoneNumber.text.length < 10 ||
                                    !isNumber(phoneNumber.text)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Invalid Mobile Number $mobile")),
                                  );
                                  return;
                                }
                              },
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
                                    prefixIcon:
                                        const Icon(Icons.email_outlined),
                                    prefixIconColor: AppColors.yellow,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.darkYellow),
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
                              title: 'Area Name',
                              keyboardType: TextInputType.name,
                              prefixIcon: const Icon(Icons.location_searching),
                              ontap: (p0) {},
                            ),
                            MyTextField(
                              controller: streetName,
                              title: 'Street Name',
                              keyboardType: TextInputType.name,
                              prefixIcon: const Icon(Icons.edit_road_rounded),
                              ontap: (p0) {},
                            ),
                            MyTextField(
                              controller: buildingNameorNumber,
                              title: 'Building Name or Number',
                              keyboardType: TextInputType.name,
                              prefixIcon:
                                  const Icon(Icons.location_city_outlined),
                              ontap: (p0) {},
                            ),
                            MyTextField(
                              controller: floor,
                              title: 'Floor',
                              keyboardType: TextInputType.name,
                              prefixIcon: const Icon(Icons.stairs),
                              ontap: (p0) {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (state is ErrorFetchingData) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
