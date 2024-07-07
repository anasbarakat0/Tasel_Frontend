import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tasel_frontend/Model/provider_info.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/Widgets/my_text_field.dart';
import 'package:tasel_frontend/Widgets/scaffold_gradient.dart';
import 'package:tasel_frontend/bloc/provider_info_bloc.dart';
import 'package:tasel_frontend/service/fetch_categories.dart';
import 'package:tasel_frontend/service/update_provider.dart';
import 'package:tasel_frontend/theme/colors.dart';
import 'package:tasel_frontend/theme/google_map_style.dart';

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
  late TextEditingController facebookPage;
  late TextEditingController instagramAccount;
  late TextEditingController websiteUrl;
  late TextEditingController email;
  late TextEditingController areaName;
  late TextEditingController streetName;
  late TextEditingController buildingNameorNumber;
  late TextEditingController floor;

  final Completer<GoogleMapController> _controller = Completer();
  static late CameraPosition _kGooglePlex;
  BitmapDescriptor? ProviderMarkerIcon;
  LatLng _markerPosition = const LatLng(33.513835, 36.276685);

  Future<void> loadCustomMarker() async {
    ProviderMarkerIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(40, 40)),
      'assets/taselUser.png',
    );
    setState(() {});
  }

  String mobile = '';
  bool isEmailCorrect = false;
  late String _selectedCategory;
  bool disable = false;

  bool isNumber(String str) {
    final numericRegex = RegExp(r'^-?[0-9]+$');
    return numericRegex.hasMatch(str);
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _onMapLongPress(LatLng position) {
    setState(() {
      _markerPosition = position;
    });
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  void initState() {
    name = TextEditingController();
    phoneNumber = TextEditingController();
    landlines = TextEditingController();
    whatsappNumber = TextEditingController();
    facebookPage = TextEditingController();
    instagramAccount = TextEditingController();
    websiteUrl = TextEditingController();
    email = TextEditingController();
    areaName = TextEditingController();
    streetName = TextEditingController();
    buildingNameorNumber = TextEditingController();
    floor = TextEditingController();
    _kGooglePlex = const CameraPosition(
      target: LatLng(33.513835, 36.276685),
      zoom: 13.5,
    );
    loadCustomMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProviderInfoBloc(),
      child: Builder(builder: (context) {
        context
            .read<ProviderInfoBloc>()
            .add(ShowProviderInfo(idProvider: widget.tokenId.id));
        return GradientScaffold(
          body: BlocListener<ProviderInfoBloc, ProviderInfoState>(
            listener: (context, state) {
              if (state is SuccessShowProviderInfo) {
                if (!disable) {
                  name.text = state.provider.name;
                  phoneNumber.text = state.provider.phoneNumbers.join(', ');
                  landlines.text = state.provider.landlines.join(', ');
                  whatsappNumber.text =
                      state.provider.whatsappNumber.toString();
                  _selectedCategory = state.provider.category;
                  facebookPage.text = state.provider.facebookPage;
                  instagramAccount.text = state.provider.instagramAccount;
                  websiteUrl.text = state.provider.websiteUrl;
                  email.text = state.provider.email;
                  areaName.text = state.provider.address.areaName;
                  streetName.text = state.provider.address.streetName;
                  buildingNameorNumber.text =
                      state.provider.address.buildingNameorNumber;
                  floor.text = state.provider.address.floor;
                  _markerPosition =
                      LatLng(state.provider.latitude, state.provider.longitude);
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 16,
                                ),
                                const Text(
                                  'Your Info...',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                FloatingActionButton.extended(
                                  onPressed: () async {
                                    if (disable) {
                                      ProviderInfo provider = ProviderInfo(
                                          address: Address(
                                            areaName: areaName.text,
                                            streetName: streetName.text,
                                            buildingNameorNumber:
                                                buildingNameorNumber.text,
                                            floor: floor.text,
                                          ),
                                          profileImage: '',
                                          name: name.text,
                                          longitude: _markerPosition.longitude,
                                          latitude: _markerPosition.latitude,
                                          phoneNumbers: phoneNumber.text
                                              .split(',')
                                              .map((e) => int.parse(e.trim()))
                                              .toList(),
                                          landlines: landlines.text
                                              .split(',')
                                              .map((e) => int.parse(e.trim()))
                                              .toList(),
                                          whatsappNumber:
                                              int.parse(whatsappNumber.text),
                                          category: _selectedCategory,
                                          email: email.text,
                                          facebookPage: facebookPage.text,
                                          facebookUsername: '',
                                          instagramAccount:
                                              instagramAccount.text,
                                          instagramUsername: '',
                                          websiteUrl: websiteUrl.text);
                                      var edit = await updateProvider(
                                          widget.tokenId, provider);

                                      if (edit) {
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  "Your data has been changed"),
                                              backgroundColor: Colors.green),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  "Error, Try again later")),
                                        );
                                      }
                                    } else {}
                                  },
                                  icon: const Icon(Icons.save),
                                  elevation: 1,
                                  label: const Text('Save changes'),
                                  backgroundColor: disable
                                      ? AppColors.yellow
                                      : AppColors.grey,
                                  foregroundColor: disable
                                      ? AppColors.grey
                                      : AppColors.lightGrey,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                              ],
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
                                      color: AppColors.lightGrey,
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
                                  fillColor: Colors.white,
                                  filled: true),
                              initialCountryCode: 'SY',
                              cursorColor: AppColors.darkYellow,
                              onChanged: (phone) {
                                mobile = phone.completeNumber;
                              },
                              pickerDialogStyle: PickerDialogStyle(
                                backgroundColor: Colors.white,
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
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [Shadow.myShadow],
                                  border: Border.all(
                                    color: AppColors.lightGrey,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 2,
                                  ),
                                  child: MyDropdownMenu(
                                    onCategorySelected: _onCategorySelected,
                                  ),
                                ),
                              ),
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
                                  boxShadow: [Shadow.myShadow],
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
                                        color: AppColors.lightGrey,
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
                                    fillColor: Colors.white,
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
                            GestureDetector(
                              onVerticalDragUpdate: (details) {},
                              child: AbsorbPointer(
                                absorbing: false,
                                child: SizedBox(
                                  height: 300,
                                  child: GoogleMap(
                                    style: mapBasicStyle,
                                    buildingsEnabled: true,
                                    myLocationButtonEnabled: true,
                                    myLocationEnabled: true,
                                    initialCameraPosition: _kGooglePlex,
                                    markers: {
                                      Marker(
                                        markerId: MarkerId(state.provider.name),
                                        position: _markerPosition,
                                        icon: ProviderMarkerIcon!,
                                      ),
                                    },
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      _controller.complete(controller);
                                    },
                                    onTap: _onMapLongPress,
                                  ),
                                ),
                              ),
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
