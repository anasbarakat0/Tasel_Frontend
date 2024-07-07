import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasel_frontend/Widgets/product_list.dart';
import 'package:tasel_frontend/Widgets/provider_info_card.dart';
import 'package:tasel_frontend/Widgets/scaffold_gradient.dart';
import 'package:tasel_frontend/bloc/provider_info_bloc.dart';
import 'package:tasel_frontend/bloc/show_provider_products_bloc.dart';
import 'package:tasel_frontend/google_map_page.dart';
import 'package:tasel_frontend/main.dart';
import 'package:tasel_frontend/map_page.dart';
import 'package:tasel_frontend/theme/colors.dart';

class ProviderPage extends StatefulWidget {
  final String id;
  const ProviderPage({
    super.key,
    required this.id,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProviderPageState createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  bool info = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProviderInfoBloc()..add(ShowProviderInfo(idProvider: widget.id)),
        ),
        BlocProvider(
          create: (context) => ShowProviderProductsBloc()
            ..add(ShowProviderProducts(storeId: widget.id)),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Stack(
            children: [
              GradientScaffold(
                body: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        BlocBuilder<ProviderInfoBloc, ProviderInfoState>(
                          builder: (context, state) {
                            if (state is ErrorFetchingData) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      state.message,
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProviderPage(
                                              id: widget.id,
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
                                        child: Image.network(
                                          "$baseurl/${state.provider.profileImage}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      state.provider.name,
                                      style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [Shadow.myShadow],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    info = true;
                                                  });
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  decoration: info
                                                      ? BoxDecoration(
                                                          color:
                                                              AppColors.yellow,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        )
                                                      : BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: AppColors
                                                                  .lightYellow),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            Shadow.myShadow
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Info',
                                                    style: info
                                                        ? const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight.bold)
                                                        : TextStyle(
                                                            color: AppColors
                                                                .yellow,
                                                            fontSize: 20,
                                                          ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    info = false;
                                                  });
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  decoration: !info
                                                      ? BoxDecoration(
                                                          color:
                                                              AppColors.yellow,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        )
                                                      : BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: AppColors
                                                                  .lightYellow),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            Shadow.myShadow
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Products',
                                                    style: !info
                                                        ? const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight.bold)
                                                        : TextStyle(
                                                            color: AppColors
                                                                .yellow,
                                                            fontSize: 20,
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    info
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Center(
                                                child: ProviderInfoCard(
                                                  longitude:
                                                      state.provider.longitude,
                                                  latitude:
                                                      state.provider.latitude,
                                                  phoneNumbers: state
                                                      .provider.phoneNumbers,
                                                  landlines:
                                                      state.provider.landlines,
                                                  whatsappNumber: state
                                                      .provider.whatsappNumber,
                                                  category:
                                                      state.provider.category,
                                                  email: state.provider.email,
                                                  facebookPage: state
                                                      .provider.facebookPage,
                                                  facebookUsername: state
                                                      .provider
                                                      .facebookUsername,
                                                  instagramAccount: state
                                                      .provider
                                                      .instagramAccount,
                                                  instagramUsername: state
                                                      .provider
                                                      .instagramUsername,
                                                  areaName: state.provider
                                                      .address.areaName,
                                                  streetName: state.provider
                                                      .address.streetName,
                                                  buildingNameorNumber: state
                                                      .provider
                                                      .address
                                                      .buildingNameorNumber,
                                                  floor: state
                                                      .provider.address.floor,
                                                  websiteUrl:
                                                      state.provider.websiteUrl,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 16.0),
                                                child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        (MaterialPageRoute(
                                                          builder: (context) =>
                                                              GoogleMapPage(
                                                                  lat: state
                                                                      .provider
                                                                      .latitude,
                                                                  lng: state
                                                                      .provider
                                                                      .longitude),
                                                        )),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0),
                                                      child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          height: 50,
                                                          width: 75,
                                                          decoration:
                                                              BoxDecoration(
                                                            boxShadow: [
                                                              Shadow.myShadow
                                                            ],
                                                            color: AppColors
                                                                .yellow,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child:
                                                              Icon(Icons.map)),
                                                    )),
                                              )
                                            ],
                                          )
                                        : BlocBuilder<ShowProviderProductsBloc,
                                            ShowProviderProductsState>(
                                            builder: (context, state) {
                                              if (state
                                                  is SuccessShowProducts) {
                                                return SizedBox(
                                                  height: 100 *
                                                      state.products.length
                                                          .toDouble(),
                                                  child: ListView.builder(
                                                      itemCount:
                                                          state.products.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Column(
                                                          children: [
                                                            MyProducts(
                                                              product: state
                                                                      .products[
                                                                  index],
                                                            ),
                                                            const Divider(),
                                                          ],
                                                        );
                                                      }),
                                                );
                                              } else if (state
                                                  is ErrorFetchingProducts) {
                                                return Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        'Error Fetching Products',
                                                      ),
                                                      ElevatedButton.icon(
                                                        onPressed: () {
                                                          context
                                                              .read<
                                                                  ShowProviderProductsBloc>()
                                                              .add(ShowProviderProducts(
                                                                  storeId:
                                                                      widget
                                                                          .id));
                                                        },
                                                        label: const Text(
                                                            'Try Again'),
                                                        icon: const Icon(Icons
                                                            .autorenew_rounded),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                return const Padding(
                                                  padding: EdgeInsets.all(30.0),
                                                  child: Center(
                                                    child: Column(
                                                      children: [
                                                        Text('Connecting...'),
                                                        LinearProgressIndicator(),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
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
                      ],
                    ),
                  ),
                ),
              ),
              const Positioned(
                top: 20,
                left: 20,
                child: BackButton(),
              ),
            ],
          );
        },
      ),
    );
  }
}
