import 'package:dartz/dartz.dart';
import 'package:todo_task/Core/errors/failure.dart';
import 'package:todo_task/Core/usecase/base_usecase.dart';
import 'package:todo_task/features/authentication/domain/entities/user_entity.dart';
import 'package:todo_task/features/authentication/domain/repository/auth_repo.dart';

class RegisterUseCase extends BaseUseCaseWithParam<UserEntity?, RegisterParams> {
  final AuthRepo authRepo;

  RegisterUseCase(this.authRepo);

  @override
  Future<Either<Failure, UserEntity?>> call(RegisterParams params) async {
    return await authRepo.register(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}

class RegisterParams {
  final String email;
  final String password;
  final String name;

  RegisterParams(this.email, this.password, this.name);
}