import 'package:todo_task/Core/services/network/main_dio.dart';
import 'package:todo_task/features/authentication/domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResults> login(String email, String password);

  Future<ApiResults> register(String email, String password , String name);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final MyDio myDio;

  AuthRemoteDataSourceImpl({required this.myDio});
  @override
  Future<ApiResults> login(String email, String password) async{
    ApiResults  apiResults = await myDio.postData(
      endPoint: '/api/Account/Login',
      data: {"email": email, "password": password},
    );
    return apiResults;
  }

  @override
  Future<ApiResults> register(String email, String password , String name) async{
    ApiResults apiResults = await myDio.postData(
      endPoint: '/api/Account/Register',
      data: {
        "displayName": name,
        "email": email,
        "password": password,
      },
    );
    return apiResults;
  }
}
