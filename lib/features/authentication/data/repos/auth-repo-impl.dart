import 'package:dartz/dartz.dart';
import 'package:todo_task/Core/di/di.dart';
import 'package:todo_task/Core/errors/failure.dart';
import 'package:todo_task/Core/services/local/my_shared_preferences.dart';
import 'package:todo_task/Core/services/network/main_dio.dart';
import 'package:todo_task/features/authentication/data/sources/remote-data-sourcce/auth-remote-data-source.dart';
import 'package:todo_task/features/authentication/domain/entities/user_entity.dart';
import 'package:todo_task/features/authentication/domain/repository/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity?>> login(
      {required String email, required String password}) async {
    try {
      UserEntity? user = await remoteDataSource.login(email, password);
      return Right(user);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> register(
      {required String email,
      required String password,
      required String name}) async {
    try {
      UserEntity? user = await remoteDataSource.register(email, password, name);
      return Right(user);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<void> logout() async {
    remoteDataSource.logout();
  }
}
