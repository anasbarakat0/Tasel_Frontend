import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/Widgets/info_tile.dart';
import 'package:tasel_frontend/Widgets/my_button.dart';
import 'package:tasel_frontend/Widgets/scaffold_gradient.dart';
import 'package:tasel_frontend/bloc/provider_info_bloc.dart';
import 'package:tasel_frontend/login.dart';
import 'package:tasel_frontend/theme/colors.dart';

class ProviderProfilePage extends StatefulWidget {
  final TokenModel tokenId;
  const ProviderProfilePage({super.key, required this.tokenId});

  @override
  State<ProviderProfilePage> createState() => _ProviderProfilePageState();
}

class _ProviderProfilePageState extends State<ProviderProfilePage> {
  bool disable = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProviderInfoBloc(),
      child: Builder(builder: (context) {
        context
            .read<ProviderInfoBloc>()
            .add(ShowProviderInfo(idProvider: widget.tokenId.id));
        return Stack(
          children: [
            GradientScaffold(
              body: BlocListener<ProviderInfoBloc, ProviderInfoState>(
                listener: (context, state) {
                  if (state is SuccessShowProviderInfo) {
                    setState(() {});
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
                                Text(
                                  state.provider.name,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                InfoTile(
                                  label: 'Category',
                                  value: state.provider.category,
                                  icon: Icons.category,
                                ),
                                InfoTile(
                                  label: 'Phone',
                                  value: state.provider.phoneNumbers.join(', '),
                                  icon: Icons.phone,
                                ),
                                InfoTile(
                                  label: 'WhatsApp',
                                  value:
                                      state.provider.whatsappNumber.toString(),
                                  icon: Ionicons.logo_whatsapp,
                                ),
                                InfoTile(
                                  label: 'Landline',
                                  value: state.provider.landlines.join(', '),
                                  icon: Icons.contact_phone_rounded,
                                ),
                                InfoTile(
                                  label: 'Address',
                                  value: state.provider.address.areaName,
                                  icon: Icons.location_searching,
                                ),
                                InfoTile(
                                  label: 'Street',
                                  value: state.provider.address.streetName,
                                  icon: Icons.edit_road_rounded,
                                ),
                                InfoTile(
                                  label: 'Building',
                                  value: state
                                      .provider.address.buildingNameorNumber,
                                  icon: Icons.location_city_outlined,
                                ),
                                InfoTile(
                                  label: 'Floor',
                                  value: state.provider.address.floor,
                                  icon: Icons.stairs,
                                ),
                                InfoTile(
                                  label: 'Email',
                                  value: state.provider.email,
                                  icon: Icons.mail_outline_outlined,
                                ),
                                InfoTile(
                                  label: 'FaceBook',
                                  value: state.provider.facebookPage,
                                  icon: Ionicons.logo_facebook,
                                ),
                                InfoTile(
                                  label: 'Instagram',
                                  value: state.provider.instagramAccount,
                                  icon: Ionicons.logo_instagram,
                                ),
                                InfoTile(
                                  label: 'Website',
                                  value: state.provider.websiteUrl,
                                  icon: Icons.link,
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
            ),
            Positioned(
              top: 20,
              right: 20,
              child: LogoutButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
