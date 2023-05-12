

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/features/auth/cubit/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  Future<void> init() async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 2));
    emit(AuthInitial());
    emit(NotHaveCurrentUser());
  }

}
