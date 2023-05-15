import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/Core/di/di.dart';
import 'package:todo_task/Core/services/local/my_shared_preferences.dart';
import 'package:todo_task/Core/services/network/main_dio.dart';
import 'package:todo_task/features/auth/cubit/auth_states.dart';
import 'package:todo_task/features/auth/data/models/MyUser.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  UserData? currentUser;

  Future<void> init() async {
    Future.delayed(const Duration(seconds: 1), () {
      checkToken();
    });
  }

  Future<void> checkToken() async {
    String token = sl<MySharedPref>().getString(key: MySharedKeys.apiToken);
    if (token.isNotEmpty) {
    sl<MyDio>().getData(endPoint: '/api/Account').then((value) {
        if (value is ApiSuccess) {
          handleLoginResponse(value.data, '');
          emit(HaveCurrentUser());
        } else if (value is ApiFailure) {
          emit(LoginFailureState(value.message));
          print('${value.message}----------------------------------------------');
          emit(NotHaveCurrentUser());
        }
      });
    } else {
      emit(NotHaveCurrentUser());
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(RegisterLoadingState());
    ApiResults apiResults = await sl<MyDio>().postData(
      endPoint: '/api/Account/Register',
      data: {
        "displayName": name,
        "email": email,
        "password": password,
      },
    );
    if (apiResults is ApiSuccess) {
      login(email: email, password: password);
      print('register success----------------------------------------------');
    } else if (apiResults is ApiFailure) {
      emit(RegisterFailureState(apiResults.message));
    }
  }

  Future<void> login({required String email, required String password}) async {
    ApiResults apiResults = await sl<MyDio>().postData(
      endPoint: '/api/Account/Login',
      data: {"email": email, "password": password},
    );
    if (apiResults is ApiSuccess) {
      handleLoginResponse(apiResults.data, email);
      print('login success----------------------------------------------');
    } else if (apiResults is ApiFailure) {
      emit(LoginFailureState(errorMessage(apiResults.message)));

    }
  }

  String errorMessage(String msg)
  {
    switch(msg)
    {
      case '401':
        return 'Email or password is incorrect';
      case '400':
        return 'Please enter a valid data';
        case '500':
        return 'Server error';
        case '404':
        return 'Server Not found';
      default:
        return msg;
    }
  }
  void handleLoginResponse(json, String email) {
    if (json['email'] != null) {
      sl<MySharedPref>()
          .putString(key: MySharedKeys.apiToken, value: json['token']);
      currentUser = UserData.fromJson(json);
      print(
          'name ${json['displayName'].toString()}----------------------------------------------');
      print(
          'email ${json['email'].toString()}----------------------------------------------');
      print('${json['token']}----------------------------------------------');
      emit(RegisterSuccessState());
    } else {
      emit(RegisterFailureState(json['token']));
      print(
          '${json['token']}-----------------------xxxxxxxx-----------------------');
    }
  }

  Future<void> logout() async {
    sl<MySharedPref>().putString(key: MySharedKeys.apiToken, value: '');
    emit(NotHaveCurrentUser());
  }
}
