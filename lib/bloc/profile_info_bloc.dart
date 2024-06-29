// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/Model/response_user_info.dart';
import 'package:tasel_frontend/Model/user_info_model.dart';
import 'package:tasel_frontend/main.dart';

part 'profile_info_event.dart';
part 'profile_info_state.dart';

class ProfileInfoBloc extends Bloc<ProfileInfoEvent, ProfileInfoState> {
  ProfileInfoBloc() : super(ProfileInfoInitial()) {
    on<ShowProfileInfo>((event, emit) async {
      var data = await getUserInfo(event.userId.id);
      if (data is SuccessUserModel) {
        emit(SuccessProfileInfo(userInfo: data.userinfo));
      } else if (data is ErrorModel) {
        emit(ErrorProfileInfo(message: data.messge));
      } else if (data is ExceptionModel) {
        emit(ErrorProfileInfo(message: data.message));
      } else {
        emit(LoadingProfileInfo());
      }
    });
  }
}

Future<ResultUserInfo> getUserInfo(String id) async {
  try {
    Dio dio = Dio();
    Response response = await dio.get('$baseurl/users/$id');
    if (response.statusCode == 200) {
      return SuccessUserModel(userinfo: UserInfo.fromMap(response.data));
    } else {
      return ErrorModel(messge: response.data);
    }
  } on DioException catch (e) {
    return ExceptionModel(message: e.message.toString());
  }
}
