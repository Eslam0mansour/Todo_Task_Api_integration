import 'package:dartz/dartz.dart';
import 'package:todo_task/Core/errors/failure.dart';
import 'package:todo_task/Core/usecase/base_usecase.dart';
import 'package:todo_task/features/authentication/domain/repository/auth_repo.dart';

class LogoutUseCase extends BaseUseCase<void> {
  AuthRepo authRepo;

  LogoutUseCase({required this.authRepo});

  @override
  Future<Either<Failure, void>> call() async {
    return await authRepo.logout();
  }

}