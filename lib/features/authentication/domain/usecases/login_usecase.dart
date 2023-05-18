import 'package:dartz/dartz.dart';
import 'package:todo_task/Core/errors/failure.dart';
import 'package:todo_task/Core/usecase/base_usecase.dart';
import 'package:todo_task/features/authentication/domain/entities/user_entity.dart';
import 'package:todo_task/features/authentication/domain/repository/auth_repo.dart';

class LoginUseCase extends BaseUseCaseWithParam<UserEntity?, LoginParams> {
  final AuthRepo authRepo;

  LoginUseCase(this.authRepo);

  @override
  Future<Either<Failure, UserEntity?>> call(LoginParams params) async {
    return await authRepo.login(
      email: params.email,
      password: params.password,
    );
  }

}

class LoginParams {
  final String email;
  final String password;

  LoginParams(this.email, this.password);
}


