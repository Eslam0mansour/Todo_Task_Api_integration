
import 'package:todo_task/features/authentication/domain/entities/user_entity.dart';

class UserData extends UserEntity {
  UserData(
      {required super.name, required super.email, required super.password});

  Map<String, dynamic> toMap() {
    return {
      'displayName': name,
      'email': email,
      'password': password,
    };
  }

  factory UserData.fromJson(Map<String, dynamic> map) {
    return UserData(
      name: map['displayName'].toString(),
      email: map['email'],
      password: map['password'],
    );
  }
}
