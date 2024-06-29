// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/Widgets/leading.dart';
import 'package:tasel_frontend/Widgets/my_text_field.dart';
import 'package:tasel_frontend/Widgets/provider_card.dart';
import 'package:tasel_frontend/bloc/show_providers_bloc.dart';
import 'package:tasel_frontend/contact_page.dart';
import 'package:tasel_frontend/login.dart';
import 'package:tasel_frontend/map_page.dart';
import 'package:tasel_frontend/profile_page.dart';
import 'package:tasel_frontend/theme/colors.dart';

// ignore: must_be_immutable
class UserHomePage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final TokenModel tokenId;
  Set<String> category = {};
  UserHomePage({
    super.key,
    required this.tokenId,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowProvidersBloc()..add(ShowProviders()),
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
                MaterialPageRoute(builder: (context) => const MapPage()),
              );
            },
            backgroundColor: AppColors.yellow,
            foregroundColor: AppColors.grey,
            child: const Icon(Icons.location_pin),
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.grey,
                        Colors.black,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 60, bottom: 30, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 10.0, left: 20),
                          child: Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset('tasel.png')),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 12, top: 20),
                          child: Text(
                            'Welcome',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                LeadingButtons(
                    title: 'Profile',
                    icon: Icons.person,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage(userId: tokenId)),
                      );
                    }),
                LeadingButtons(
                    title: 'Contact Us',
                    icon: Icons.contact_support,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContactUsPage()),
                      );
                    }),
                LeadingButtons(
                    title: 'Log Out',
                    icon: Icons.logout_rounded,
                    onTap: () {
                      // isAuth = false;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    }),
              ],
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: MyTextField(
                  controller: searchController,
                  title: 'Search',
                  keyboardType: TextInputType.name,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Icon(Icons.search),
                  ),
                  suffix: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      context.read<ShowProvidersBloc>().add(ShowProviders());
                      searchController.clear();
                    },
                  ),
                  ontap: (String val) {
                    context
                        .read<ShowProvidersBloc>()
                        .add(SearchEvent(lexem: val));
                  },
                ),
              ),
              BlocBuilder<ShowProvidersBloc, ShowProvidersState>(
                builder: (context, state) {
                  if (state is LoadingFetching) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SuccessShowProviders) {
                    for (var e in state.providers) {
                      category.add(e.category);
                    }
                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: category.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                    child: InkWell(
                                      onTap: () {
                                        context.read<ShowProvidersBloc>().add(
                                            FilterBy(index,
                                                category:
                                                    category.elementAt(index)));
                                      },
                                      child: Container(
                                        width: 80,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          // ignore: unrelated_type_equality_checks
                                          color: (index == state.providers)
                                              ? AppColors.darkYellow
                                              : AppColors.grey,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: Text(
                                            category.elementAt(index),
                                            style: TextStyle(
                                              // ignore: unrelated_type_equality_checks
                                              color: (index == state.providers)
                                                  ? AppColors.grey
                                                  : AppColors.darkYellow,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )),
                          Expanded(
                            flex: 10,
                            child: ListView.builder(
                              itemCount: state.providers.length,
                              itemBuilder: (context, index) {
                                return ProviderCard(
                                  name: state.providers[index].name,
                                  image: state.providers[index].profileImage,
                                  category: state.providers[index].category,
                                  address:
                                      state.providers[index].address.areaName,
                                  id: state.providers[index].id,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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
                                  builder: (context) => UserHomePage(
                                    tokenId: tokenId,
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
                  } else if (state is SearchResutl) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.providers.length,
                        itemBuilder: (context, index) {
                          return ProviderCard(
                            name: state.providers[index].name,
                            image: state.providers[index].profileImage,
                            category: state.providers[index].category,
                            address: state.providers[index].address.areaName,
                            id: state.providers[index].id,
                          );
                        },
                      ),
                    );
                  } else if (state is FilterResutl) {
                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: category.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 0, 8, 8),
                                          child: InkWell(
                                            onTap: () {
                                              context
                                                  .read<ShowProvidersBloc>()
                                                  .add(FilterBy(index,
                                                      category: category
                                                          .elementAt(index)));
                                            },
                                            child: Container(
                                              width: 80,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: (index == state.index)
                                                      ? AppColors.darkYellow
                                                      : AppColors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Center(
                                                child: Text(
                                                  category.elementAt(index),
                                                  style: TextStyle(
                                                    color: (index ==
                                                            state.index)
                                                        ? AppColors.grey
                                                        : AppColors.darkYellow,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )),
                                IconButton(
                                    onPressed: () {
                                      context
                                          .read<ShowProvidersBloc>()
                                          .add(ShowProviders());
                                    },
                                    icon: const Icon(Icons.cancel))
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: ListView.builder(
                              itemCount: state.providers.length,
                              itemBuilder: (context, index) {
                                return ProviderCard(
                                  name: state.providers[index].name,
                                  image: state.providers[index].profileImage,
                                  category: state.providers[index].category,
                                  address:
                                      state.providers[index].address.areaName,
                                  id: state.providers[index].id,
                                );
                              },
                            ),
                          ),
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
        );
      }),
    );
  }
}
