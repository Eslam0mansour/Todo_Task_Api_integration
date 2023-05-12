import 'package:todo_task/features/home/data/models/TodoList.dart';

class TodosModel {
  TodosModel({
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


 factory TodosModel.fromJson(Map<String, dynamic> json) => TodosModel(
    title: json['title'] as String?,
    id: json['id'] as String?,
    isComplete: json['isComplete'] as String?,
    todoListId: json['todoListId'] as String?,
    todoList: TodoList.fromJson(json['todoList'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'id': id,
    'isComplete': isComplete,
    'todoListId': todoListId,
    'todoList': todoList.toJson(),
  };

}