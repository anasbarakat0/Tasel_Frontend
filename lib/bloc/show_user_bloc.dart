import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:tasel_frontend/Model/Signup_user_model.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/Model/response_user.dart';
import 'package:tasel_frontend/main.dart';

part 'show_user_event.dart';
part 'show_user_state.dart';

class ShowUserBloc extends Bloc<ShowUserEvent, ShowUserState> {
  ShowUserBloc() : super(ShowUserInitial()) {
    on<ShowUser>((event, emit) async {
      var data = await getUserInfo(event.token);
      if (data is SuccessShowUserModel) {
        emit(SuccessShowUser(user: data.user));
      } else {
        return emit(ErrorFetchingDataUser());
      }
    });
  }
}

Future<ResultUser> getUserInfo(TokenModel token) async {
  try {
    Dio dio = Dio();
    Response response = await dio.get('$baseurl/users/$token');
    if (response.statusCode == 200) {
      SuccessShowUserModel user = SuccessShowUserModel(
        user: UserModel.fromMap(response.data),
      );
      return user;
    } else {
      return ErrorModel(messge: 'No Internet Connection');
    }
  } on DioException catch (e) {
    return ExceptionModel(message: e.message.toString());
  }
}
