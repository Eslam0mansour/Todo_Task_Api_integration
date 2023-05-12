
import 'package:todo_task/features/home/data/models/TodoList.dart';

class Todos {
  Todos({
      this.title, 
      this.id, 
      this.isComplete, 
      this.todoListId, 
      required this.todoList,});

  String? title;
  String? id;
  String? isComplete;
  String? todoListId;
  TodoList todoList;

  factory Todos.fromJson(Map<String, dynamic> json) => Todos(
    title: json['title'] as String?,
    id: json['id'] as String?,
    isComplete: json['isComplete'] as String?,
    todoListId: json['todoListId'] as String?,
    todoList: TodoList.fromJson(json['todoList'] as Map<String, dynamic>),
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['id'] = id;
    map['isComplete'] = isComplete;
    map['todoListId'] = todoListId;
    map['todoList'] = todoList;
    return map;
  }

}