// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/Widgets/provider_card.dart';
import 'package:tasel_frontend/Widgets/scaffold_gradient.dart';
import 'package:tasel_frontend/bloc/show_providers_bloc.dart';
import 'package:tasel_frontend/filter_page.dart';
import 'package:tasel_frontend/provider/signup_provider.dart';
import 'package:tasel_frontend/provider_page.dart';
import 'package:tasel_frontend/theme/colors.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  bool Provider;
  final TokenModel tokenId;
  VoidCallback? onSeeAllPressed;
  HomePage({
    Key? key,
    required this.Provider,
    required this.tokenId,
    this.onSeeAllPressed,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  int _selectedIndex = -1;
  Set<String> category = {};

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              if (widget.Provider == false)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpProvider()));
                    },
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.lightYellow,
                            AppColors.yellow,
                            AppColors.darkYellow,
                          ],
                          stops: const [
                            0.0,
                            0.5,
                            1.0,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/taselGrey.png',
                            height: 150,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Text(
                              'Join us and be Provider...',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: AppColors.grey,
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (widget.Provider)
                SizedBox(
                  height: 20,
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: AppColors.grey,
                      ),
                    ),
                    TextButton(
                      onPressed: widget.onSeeAllPressed,
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.yellow,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocProvider(
                  create: (context) =>
                      ShowProvidersBloc()..add(ShowProviders()),
                  child: BlocBuilder<ShowProvidersBloc, ShowProvidersState>(
                    builder: (context, state) {
                      if (state is LoadingFetching) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is SuccessShowProviders) {
                        for (var e in state.providers) {
                          category.add(e.category);
                        }
                        return SizedBox(
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: category.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  right: 7,
                                  left: 7,
                                  bottom: 5,
                                ),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.resolveWith<Color>(
                                            (states) {
                                      if (states
                                          .contains(WidgetState.pressed)) {
                                        return AppColors.lightYellow;
                                      }
                                      return Colors.white;
                                    }),
                                    shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: BorderSide(
                                          color: (_selectedIndex == index)
                                              ? AppColors.darkYellow
                                              : const Color.fromARGB(
                                                  0, 255, 255, 255),
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FilterPage(
                                            category: category.elementAt(index),
                                            areaName: ''),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      category.elementAt(index),
                                      style: TextStyle(
                                          color: (_selectedIndex == index)
                                              ? AppColors.grey
                                              : AppColors.yellow,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else if (state is ErrorFetchingData) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('There is no Connection...'),
                              ElevatedButton.icon(
                                onPressed: () {
                                  context
                                      .read<ShowProvidersBloc>()
                                      .add(ShowProviders());
                                },
                                label: const Text('Try Again'),
                                icon: const Icon(Icons.autorenew_rounded),
                              ),
                            ],
                          ),
                        );
                      } else if (state is FilterResutl) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 60,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 10,
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
                                              setState(() {
                                                _selectedIndex = index;
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  Shadow.myShadow,
                                                ],
                                                color: (_selectedIndex == index)
                                                    ? AppColors.lightYellow
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                  color:
                                                      (_selectedIndex == index)
                                                          ? AppColors.darkYellow
                                                          : Colors.white,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Center(
                                                  child: Text(
                                                    category.elementAt(index),
                                                    style: TextStyle(
                                                      color: (_selectedIndex ==
                                                              index)
                                                          ? AppColors.grey
                                                          : AppColors.yellow,
                                                      fontWeight:
                                                          (_selectedIndex ==
                                                                  index)
                                                              ? FontWeight.bold
                                                              : FontWeight
                                                                  .normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      context
                                          .read<ShowProvidersBloc>()
                                          .add(ShowProviders());
                                      setState(() {
                                        _selectedIndex = -1;
                                      });
                                    },
                                    icon: const Icon(Icons.cancel),
                                  ),
                                ],
                              ),
                            ),
                            // if (widget.Provider)
                            SizedBox(
                              height: 300,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.providers.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProviderPage(
                                              id: state.providers[index].id,
                                            ),
                                          ),
                                        );
                                      },
                                      child: ProviderCard(
                                        name: state.providers[index].name,
                                        image:
                                            state.providers[index].profileImage,
                                        category:
                                            state.providers[index].category,
                                        address: state
                                            .providers[index].address.areaName,
                                        id: state.providers[index].id,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(child: LinearProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Providers',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: AppColors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const FilterPage(category: '', areaName: ''),
                          ),
                        );
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.yellow,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BlocProvider(
                create: (context) => ShowProvidersBloc()..add(ShowProviders()),
                child: BlocBuilder<ShowProvidersBloc, ShowProvidersState>(
                  builder: (context, state) {
                    if (state is LoadingFetching) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SuccessShowProviders) {
                      if (widget.Provider) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 0.8,
                                ),
                                itemCount: state.providers.length,
                                itemBuilder: (context, index) {
                                  final provider = state.providers[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProviderPage(
                                            id: provider.id,
                                          ),
                                        ),
                                      );
                                    },
                                    child: FittedBox(
                                      child: ProviderCard(
                                        id: provider.id,
                                        name: provider.name,
                                        image: provider.profileImage,
                                        category: provider.category,
                                        address: provider.address.areaName,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return SizedBox(
                          height: 300,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.providers.length >= 7
                                ? 7
                                : state.providers.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  if (index == 0) const SizedBox(width: 20),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProviderPage(
                                              id: state.providers[index].id,
                                            ),
                                          ),
                                        );
                                      },
                                      child: ProviderCard(
                                        name: state.providers[index].name,
                                        image:
                                            state.providers[index].profileImage,
                                        category:
                                            state.providers[index].category,
                                        address: state
                                            .providers[index].address.areaName,
                                        id: state.providers[index].id,
                                      ),
                                    ),
                                  ),
                                  if (index + 1 == 7) const SizedBox(width: 20),
                                ],
                              );
                            },
                          ),
                        );
                      }
                    } else if (state is ErrorFetchingData) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('There is no Connection...'),
                            ElevatedButton.icon(
                              onPressed: () {
                                context
                                    .read<ShowProvidersBloc>()
                                    .add(ShowProviders());
                              },
                              label: const Text('Try Again'),
                              icon: const Icon(Icons.autorenew_rounded),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                          child: Column(
                        children: [
                          LinearProgressIndicator(),
                        ],
                      ));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
