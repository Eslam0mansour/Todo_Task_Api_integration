
import 'dart:convert';

import 'package:todo_task/features/authentication/domain/entities/user_entity.dart';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData extends UserEntity{
  String? _name;
  String? _email;
  String? _password;

  UserData({
    String? name,
    String? email,
    String? password,
  }) {
    _name = name;
    _email = email;
    _password = password;
  }

  UserData.fromJson(dynamic json) {
    _name = json['displayName'].toString();
    _email = json['email'];
    _password = json['password'];
  }



  UserData copyWith({
    String? name,
    String? email,
    String? password,
  }) =>
      UserData(
        name: name ?? _name,
        email: email ?? _email,
        password: password ?? _password,
      );

  String get name => _name ?? "User Name";

  String get email => _email ?? "User Email";

  String get password => _password ?? "User Password";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['displayName'] = _name;
    map['email'] = _email;
    map['password'] = _password;
    return map;
  }
}
