// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:tasel_frontend/Model/product_model.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/Widgets/product_list.dart';
import 'package:tasel_frontend/bloc/show_provider_products_bloc.dart';
import 'package:tasel_frontend/edit_product.dart';
import 'package:tasel_frontend/product_deleting_message.dart';
import 'package:tasel_frontend/theme/colors.dart';

class ProductPage extends StatefulWidget {
  final TokenModel tokenId;
  const ProductPage({
    super.key,
    required this.tokenId,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowProviderProductsBloc()
        ..add(
          ShowProviderProducts(storeId: widget.tokenId.id),
        ),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: BlocBuilder<ShowProviderProductsBloc,
                ShowProviderProductsState>(
              builder: (context, state) {
                if (state is ErrorFetchingProducts) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is SuccessShowProducts) {
                  return ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        startActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: Colors.red,
                              icon: Icons.delete_outline_outlined,
                              label: 'Delete',
                              onPressed: (BuildContext context) {
                                showMyDialog(context, state.products[index],
                                    widget.tokenId);
                                context.read<ShowProviderProductsBloc>().add(
                                      ShowProviderProducts(
                                          storeId: widget.tokenId.id),
                                    );
                              },
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: AppColors.yellow,
                              icon: Icons.edit,
                              label: 'Edit Product',
                              onPressed: (BuildContext context) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProduct(
                                          product: state.products[index]),
                                    ));
                              },
                            ),
                          ],
                        ),
                        child: MyProducts(
                          product: ProductModel(
                            id: state.products[index].id,
                            picture: state.products[index].picture,
                            name: state.products[index].name,
                            price: state.products[index].price,
                            description: state.products[index].description,
                            storeId: state.products[index].storeId,
                          ),
                        ),
                      );
                    },
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
