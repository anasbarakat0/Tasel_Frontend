// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tasel_frontend/Widgets/provider_info_card.dart';
import 'package:tasel_frontend/bloc/provider_info_bloc.dart';
import 'package:tasel_frontend/map_sample.dart';
import 'package:tasel_frontend/theme/colors.dart';

class ProviderPage extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  final String id;
  ProviderPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProviderInfoBloc()..add(ShowProviderInfo(idProvider: id)),
      child: Builder(builder: (context) {
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MapSample()),
              );
            },
            backgroundColor: AppColors.yellow,
            foregroundColor: AppColors.grey,
            child: const Icon(Icons.location_pin),
          ),
          body: BlocBuilder<ProviderInfoBloc, ProviderInfoState>(
            builder: (context, state) {
              if (state is LoadingFetching) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ErrorFetchingData) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'There is an Error',
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProviderPage(
                                id: id,
                              ),
                            ),
                          );
                        },
                        label: const Text('Try Again'),
                        icon: const Icon(Icons.autorenew_rounded),
                      ),
                    ],
                  ),
                );
              } else if (state is SuccessShowProviderInfo) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16.0,
                        ),
                        child: SizedBox(
                          height: 75,
                          child: Image.asset(
                            'tasel.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ProviderInfoCard(
                        profileImage: state.provider.profileImage,
                        name: state.provider.name,
                        longitude: state.provider.longitude,
                        latitude: state.provider.latitude,
                        phoneNumbers: state.provider.phoneNumbers,
                        landlines: state.provider.landlines,
                        whatsappNumber: state.provider.whatsappNumber,
                        category: state.provider.category,
                        email: state.provider.email,
                        facebookPage: state.provider.facebookPage,
                        facebookUsername: state.provider.facebookUsername,
                        instagramAccount: state.provider.instagramAccount,
                        instagramUsername: state.provider.instagramUsername,
                        areaName: state.provider.address.areaName,
                        streetName: state.provider.address.streetName,
                        buildingNameorNumber:
                            state.provider.address.buildingNameorNumber,
                        floor: state.provider.address.floor,
                      )
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: LinearProgressIndicator(),
                );
              }
            },
          ),
        );
      }),
    );
  }
}
