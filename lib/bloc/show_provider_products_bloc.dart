import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:tasel_frontend/Model/product_model.dart';
import 'package:tasel_frontend/Model/response_products_model.dart';
import 'package:tasel_frontend/main.dart';

part 'show_provider_products_event.dart';
part 'show_provider_products_state.dart';

class ShowProviderProductsBloc
    extends Bloc<ShowProviderProductsEvent, ShowProviderProductsState> {
  ShowProviderProductsBloc() : super(ShowProviderProductsInitial()) {
    on<ShowProviderProducts>((event, emit) async {
      var data = await showProviderProducts(event.storeId);
      if (data is ListOf<ProductModel>) {
        emit(SuccessShowProducts(products: data.resutl));
      } else if (data is ErrorProducts) {
        emit(ErrorFetchingProducts(message: data.message));
      } else if (data is ExceptionProducts) {
        emit(ErrorFetchingProducts(message: data.message));
      } else {
        emit(ErrorFetchingProducts(message: 'There is an Error'));
      }
    });
  }
}

Future<ProductsResult> showProviderProducts(String storeId) async {
  try {
    Dio dio = Dio();
    Response response = await dio.get('$baseurl/store/$storeId/products');

    if (response.statusCode == 200) {
      List<ProductModel> products = List.generate(
        response.data.length,
        (index) => ProductModel.fromMap(
          response.data[index],
        ),
      );
      return ListOf<ProductModel>(resutl: products);
    } else {
      return ErrorProducts(message: response.data);
    }
  } on DioException catch (e) {
    return ExceptionProducts(message: e.message.toString());
  }
}