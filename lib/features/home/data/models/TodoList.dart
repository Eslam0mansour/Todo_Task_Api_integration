import 'package:todo_task/features/home/data/models/Todos.dart';


class TodoList {
  TodoList({
      this.title,
      this.userId, 
      this.id, 
      this.description, 
      required this.todos,
      // this.user,
  });

  String? title;
  String? userId;
  String? id;
  String? description;
  List<Todos>? todos;
  // User? user;

  TodoList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    userId = json['userId'];
    id = json['id'];
    description = json['description'];
    todos = List.from(json['todos']).map((e) => Todos.fromJson(e)).toList();
    // user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['userId'] = userId;
    map['id'] = id;
    map['description'] = description;
    map['todos'] = todos!.map((v) => v.toJson()).toList();
    // if (user != null) {
    //   map['user'] = user!.toJson();
    // }
    return map;
  }

}