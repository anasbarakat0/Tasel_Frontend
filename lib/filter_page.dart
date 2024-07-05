import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasel_frontend/Widgets/provider_card.dart';
import 'package:tasel_frontend/Widgets/scaffold_gradient.dart';
import 'package:tasel_frontend/bloc/show_provoders_filter_bloc.dart';
import 'package:tasel_frontend/provider_page.dart';

class FilterPage extends StatefulWidget {
  final String category;
  final String areaName;

  const FilterPage({
    super.key,
    required this.category,
    required this.areaName,
  });

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String categoryFilter = '';
  String areaNameFilter = '';

  @override
  initState() {
    super.initState();
    categoryFilter = widget.category;
    areaNameFilter = widget.areaName;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowProvodersFilterBloc()
        ..add(ShowFilterProvider(
            category: categoryFilter, areaName: areaNameFilter)),
      child: Builder(builder: (context) {
        return GradientScaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 75,
                  ),
                  BlocBuilder<ShowProvodersFilterBloc,
                      ShowProvodersFilterState>(
                    builder: (context, state) {
                      if (state is ShowProvodersFilterInitial) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ShowProvodersFilterSuccess) {
                        return Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              // crossAxisSpacing: 10,
                              childAspectRatio: 0.8,
                            ),
                            scrollDirection: Axis.vertical,
                            itemCount: state.provider.length,
                            itemBuilder: (context, index) {
                              return FittedBox(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProviderPage(
                                          id: state.provider[index].id,
                                        ),
                                      ),
                                    );
                                  },
                                  child: FittedBox(
                                    child: ProviderCard(
                                      name: state.provider[index].name,
                                      image: state
                                          .provider[index].profileImage,
                                      category:
                                          state.provider[index].category,
                                      address: state
                                          .provider[index].address.areaName,
                                      id: state.provider[index].id,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else if (state is ErrorShowProvidersFilter) {
                        return Center(
                          child: Column(
                            children: [
                              Text(state.message),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<ShowProvodersFilterBloc>().add(
                                      ShowFilterProvider(
                                          areaName: '', category: ''));
                                },
                                child: const Text('Try again'),
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
              Positioned(
                top: 20,
                left: 20,
                child: BackButton(
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
