import 'package:dartz/dartz.dart';
import 'package:todo_task/Core/errors/failure.dart';
import 'package:todo_task/features/authentication/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity?>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity?>> register({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, void>> logout();

}
