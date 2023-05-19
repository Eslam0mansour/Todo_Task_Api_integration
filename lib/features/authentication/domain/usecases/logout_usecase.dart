import 'package:todo_task/Core/usecase/base_usecase.dart';
import 'package:todo_task/features/authentication/domain/repository/auth_repo.dart';

class LogoutUseCase extends UseCase<void> {
  final AuthRepo authRepo;

  LogoutUseCase(this.authRepo);

  @override
  Future<void> call() async {
    return await authRepo.logout();
  }

}