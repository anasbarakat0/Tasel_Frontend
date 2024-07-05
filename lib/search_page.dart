import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasel_frontend/Widgets/my_text_field.dart';
import 'package:tasel_frontend/Widgets/result_panels.dart';
import 'package:tasel_frontend/Widgets/scaffold_gradient.dart';
import 'package:tasel_frontend/bloc/show_providers_bloc.dart';
import 'package:tasel_frontend/filter_page.dart';
import 'package:tasel_frontend/theme/colors.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowProvidersBloc(),
      child: Builder(builder: (context) {
        context.read<ShowProvidersBloc>().add(ShowProviders());
        return GradientScaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: MyTextField(
                        controller: search,
                        suffix: IconButton(
                          onPressed: () {
                            context
                                .read<ShowProvidersBloc>()
                                .add(ShowProviders());
                            search.clear();
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: AppColors.lightGrey,
                          ),
                        ),
                        title: 'Search',
                        keyboardType: TextInputType.name,
                        ontap: (String search) {
                          context
                              .read<ShowProvidersBloc>()
                              .add(SearchEvent(lexem: search));
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: BlocBuilder<ShowProvidersBloc, ShowProvidersState>(
                    builder: (context, state) {
                      if (state is LoadingFetching) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SuccessShowProviders) {
                        Set<String> category =
                            state.providers.map((e) => e.category).toSet();
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: category.length,
                          itemBuilder: (context, index) {
                            String categoryItem = category.elementAt(index);
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FilterPage(
                                          category: categoryItem, areaName: ''),
                                    ),
                                  );
                                },
                                child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 2) -
                                          30,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    boxShadow: [Shadow.myShadow],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'assets/tasel.png',
                                          height: 80,
                                        ),
                                        Text(
                                          categoryItem,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppColors.grey,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is ErrorFetchingData) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('There is an Error'),
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
                      } else if (state is SearchResutl) {
                        return ListView.builder(
                          itemCount: state.providers.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 80,
                              child: ResultPanel(
                                name: state.providers[index].name,
                                image: state.providers[index].profileImage,
                                id: state.providers[index].id,
                              ),
                            );
                          },
                        );
                      } else if (state is FilterResutl) {
                        Set<String> category =
                            state.providers.map((e) => e.category).toSet();
                        return Column(
                          children: [
                            SizedBox(
                              height: 40,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: category.length,
                                      itemBuilder: (context, index) {
                                        String categoryItem =
                                            category.elementAt(index);
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 0, 8, 8),
                                          child: InkWell(
                                            onTap: () {
                                              context
                                                  .read<ShowProvidersBloc>()
                                                  .add(
                                                    FilterBy(index,
                                                        category: categoryItem),
                                                  );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Center(
                                                  child: Text(
                                                    categoryItem,
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.lightGrey,
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
                                    },
                                    icon: Icon(
                                      Icons.cancel,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.providers.length,
                                itemBuilder: (context, index) {
                                  final provider = state.providers[index];
                                  return SizedBox(
                                    height: 80,
                                    child: ResultPanel(
                                      name: provider.name,
                                      image: provider.profileImage,
                                      id: provider.id,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: LinearProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
