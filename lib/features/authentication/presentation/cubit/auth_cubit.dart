import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/Core/di/di.dart';
import 'package:todo_task/Core/services/local/my_shared_preferences.dart';
import 'package:todo_task/Core/services/network/main_dio.dart';
import 'package:todo_task/features/authentication/domain/entities/user_entity.dart';
import 'package:todo_task/features/authentication/domain/usecases/login_usecase.dart';
import 'package:todo_task/features/authentication/domain/usecases/register_usecase.dart';
import 'package:todo_task/features/authentication/presentation/cubit/auth_states.dart';
import 'package:todo_task/features/authentication/data/models/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.loginUseCase, this.registerUseCase) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);


  final LoginUseCase loginUseCase;

  final RegisterUseCase registerUseCase;

  UserEntity? user;
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
  Future<void> logout() async {
    sl<MySharedPref>().putString(key: MySharedKeys.apiToken, value: '');
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

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:todo_task/Core/di/di.dart';
// import 'package:todo_task/Core/services/local/my_shared_preferences.dart';
// import 'package:todo_task/Core/services/network/main_dio.dart';
// import 'package:todo_task/features/authentication/presentation/cubit/auth_states.dart';
// import 'package:todo_task/features/authentication/data/models/user_model.dart';
//
// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(AuthInitial());
//
//   static AuthCubit get(context) => BlocProvider.of(context);
//
//   UserData? currentUser;
//
//   Future<void> init() async {
//     Future.delayed(const Duration(seconds: 1), () {
//       checkToken();
//     });
//   }
//
//   Future<void> checkToken() async {
//     String token = sl<MySharedPref>().getString(key: MySharedKeys.apiToken);
//     if (token.isNotEmpty) {
//       sl<MyDio>().getData(endPoint: '/api/Account').then((value) {
//         if (value is ApiSuccess) {
//           handleLoginResponse(value.data, '');
//           emit(HaveCurrentUser());
//         } else if (value is ApiFailure) {
//           emit(LoginFailureState(value.message));
//           emit(NotHaveCurrentUser());
//         }
//       });
//     } else {
//       emit(NotHaveCurrentUser());
//     }
//   }
//
//   Future<void> register({
//     required String email,
//     required String password,
//     required String name,
//   }) async {
//     emit(RegisterLoadingState());
//     ApiResults apiResults = await sl<MyDio>().postData(
//       endPoint: '/api/Account/Register',
//       data: {
//         "displayName": name,
//         "email": email,
//         "password": password,
//       },
//     );
//     if (apiResults is ApiSuccess) {
//       login(email: email, password: password);
//     } else if (apiResults is ApiFailure) {
//       emit(RegisterFailureState(errorMessage(apiResults.message)));
//     }
//   }
//
//   Future<void> login({required String email, required String password}) async {
//     emit(LoginLoadingState());
//     ApiResults apiResults = await sl<MyDio>().postData(
//       endPoint: '/api/Account/Login',
//       data: {"email": email, "password": password},
//     );
//     if (apiResults is ApiSuccess) {
//       handleLoginResponse(apiResults.data, email);
//     } else if (apiResults is ApiFailure) {
//       emit(LoginFailureState(errorMessage(apiResults.message)));
//     }
//   }
//
//   void handleLoginResponse(json, String email) {
//     if (json['email'] != null) {
//       sl<MySharedPref>()
//           .putString(key: MySharedKeys.apiToken, value: json['token']);
//       currentUser = UserData.fromJson(json);
//       emit(RegisterSuccessState());
//     } else {
//       emit(RegisterFailureState(errorMessage(json['message'])));
//     }
//   }
//
//   Future<void> logout() async {
//     sl<MySharedPref>().putString(key: MySharedKeys.apiToken, value: '');
//     emit(NotHaveCurrentUser());
//   }
//
//   String errorMessage(String msg) {
//     switch (msg) {
//       case '401':
//         return 'Email or password is incorrect';
//       case '400':
//         return 'Please enter a valid data';
//       case '500':
//         return 'Server error';
//       case '404':
//         return 'Server Not found';
//       default:
//         return msg;
//     }
//   }
// }
