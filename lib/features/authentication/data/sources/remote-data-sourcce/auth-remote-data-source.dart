import 'package:todo_task/Core/services/network/main_dio.dart';
import 'package:todo_task/features/authentication/data/models/user_model.dart';
import 'package:todo_task/features/authentication/domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity> login(String email, String password);

  Future<UserEntity> register(String email, String password , String name);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final MyDio myDio;

  AuthRemoteDataSourceImpl({required this.myDio});
  @override
  Future<UserEntity> login(String email, String password) async{
    ApiResults  apiResults = await myDio.postData(
      endPoint: '/api/Account/Login',
      data: {"email": email, "password": password},
    );
    if (apiResults is ApiSuccess) {
      return UserData.fromJson(apiResults.data);
    } else if (apiResults is ApiFailure) {
      throw Exception(apiResults.message);
    } else {
      throw Exception('Something went wrong');
    }
  }

  @override
  Future<UserEntity> register(String email, String password , String name) async{
    ApiResults apiResults = await myDio.postData(
      endPoint: '/api/Account/Register',
      data: {
        "displayName": name,
        "email": email,
        "password": password,
      },
    );
    if (apiResults is ApiSuccess) {
      return UserData.fromJson(apiResults.data);
    } else if (apiResults is ApiFailure) {
      throw Exception(apiResults.message);
    } else {
      throw Exception('Something went wrong');
    }
  }
}
