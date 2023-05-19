import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/Core/di/di.dart';
import 'package:todo_task/Core/services/local/my_shared_preferences.dart';
import 'package:todo_task/Core/services/network/main_dio.dart';
import 'package:todo_task/features/authentication/domain/entities/user_entity.dart';
import 'package:todo_task/features/authentication/domain/usecases/login_usecase.dart';
import 'package:todo_task/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:todo_task/features/authentication/domain/usecases/register_usecase.dart';
import 'package:todo_task/features/authentication/presentation/cubit/auth_states.dart';
import 'package:todo_task/features/authentication/data/models/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.loginUseCase, this.registerUseCase , this.logoutUseCase) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);


  final LoginUseCase loginUseCase;

  final RegisterUseCase registerUseCase;

  final LogoutUseCase logoutUseCase ;

  UserEntity? user;

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
          user = UserData.fromJson(value.data);
          sl<MySharedPref>()
              .putString(key: MySharedKeys.apiToken, value: user!.tokenE);
          emit(RegisterSuccessState());
          emit(HaveCurrentUser());
        } else if (value is ApiFailure) {
          emit(LoginFailureState(value.message));
          emit(NotHaveCurrentUser());
        }
      });
    } else {
      emit(NotHaveCurrentUser());
    }
  }


  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());
    final result = await loginUseCase(LoginParams(email, password));
    result.fold((l) {
      emit(LoginFailureState(errorMessage(l.message)));
    }, (r) {
      sl<MySharedPref>()
          .putString(key: MySharedKeys.apiToken, value: r!.tokenE);
      user = r;
      emit(RegisterSuccessState());
    });
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(RegisterLoadingState());
    final result = await registerUseCase(RegisterParams(email, password, name));
    result.fold((l) {
      emit(RegisterFailureState(errorMessage(l.message)));
    }, (r) {
      login(email: email, password: password);
    });
  }

  Future<void> logout() async {
    logoutUseCase();
    emit(NotHaveCurrentUser());
  }



  String errorMessage(String msg) {
    switch (msg) {
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
}