import 'package:dartz/dartz.dart';
import 'package:todo_task/Core/errors/failure.dart';

abstract class BaseUseCaseWithParam<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

abstract class BaseUseCase<T> {
  Future<Either<Failure, T>> call();
}
abstract class UseCase<T> {
  Future<T> call();
}