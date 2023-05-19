import 'package:todo_task/features/authentication/domain/entities/user_entity.dart';

class UserData extends UserEntity {
  String? name;
  String? email;
  String? password;
  String? token;

  UserData({
    required this.name,
    required this.email,
    required this.password,
    required this.token,
  }) : super(
          nameE: name,
          emailE: email,
          passwordE: password,
          tokenE: token,
        );

  Map<String, dynamic> toMap() {
    return {
      'displayName': name,
      'email': email,
      'password': password,
      'token': token,
    };
  }

  factory UserData.fromJson(Map<String, dynamic> map) {
    return UserData(
      name: map['displayName'].toString(),
      email: map['email'],
      password: map['password'].toString(),
      token: map['token'].toString(),
    );
  }
}
