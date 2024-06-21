import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:tasel_frontend/Model/response_user_info.dart';
import 'package:tasel_frontend/Model/user_info_model.dart';
import 'package:tasel_frontend/main.dart';

part 'profile_info_event.dart';
part 'profile_info_state.dart';

class ProfileInfoBloc extends Bloc<ProfileInfoEvent, ProfileInfoState> {
  ProfileInfoBloc() : super(ProfileInfoInitial()) {
    on<ShowProfileInfo>((event, emit) async {
      var data = await getUserInfo(event.userId);
      if (data is SuccessUserModel) {
        print('object 1');
        emit(SuccessProfileInfo(userInfo: data.userinfo));
      } else if (data is ErrorModel) {
        print('object 2');
        emit(ErrorProfileInfo(message: data.messge));
      } else if (data is ExceptionModel) {
        print('object 3');
        emit(ErrorProfileInfo(message: data.message));
      } else {
        print('object 4');
        emit(LoadingProfileInfo());
      }
    });
  }
}

Future<ResultUserInfo> getUserInfo(String id) async {
  try {
    print('object 8');
    Dio dio = Dio();
    Response response = await dio.get('$baseurl/users/$id');
    if (response.statusCode == 200) {
      print('object 5 issss ${response.data}');
      return SuccessUserModel(userinfo: UserInfo.fromMap(response.data));
      // return SuccessUserModel(
      //   userinfo: UserInfo(
      //     id: '66752622900a3e935505dc62',
      //     name: 'name',
      //     phone: 6532417,
      //     email: 'email',
      //     address: 'address',
      //   ),
      // );
    } else {
      print('object 6');
      return ErrorModel(messge: response.data);
    }
  } on DioException catch (e) {
    print('object 7');
    return ExceptionModel(message: e.message.toString());
  }
}
