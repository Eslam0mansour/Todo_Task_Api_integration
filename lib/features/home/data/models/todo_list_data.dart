//    {
//         "id": 1,
//         "title": "aaaaaaaaaaaaaa",
//         "description": "aaaaaaaaaaaaaaaaaaaaa",
//         "icon": "aaaaaaaaaaaaaa",
//         "todosCount": 2,
//         "doneCount": 0
//     }

class TodoListData {
  int? id;
  String? title;
  String? description;
  String? icon;
  int? todosCount;
  int? doneCount;

  TodoListData({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.todosCount,
    required this.doneCount,
  });

  factory TodoListData.fromJson(Map<String, dynamic> json) {
    return TodoListData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      icon: json['icon'],
      todosCount: json['todosCount'],
      doneCount: json['doneCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'todosCount': todosCount,
      'doneCount': doneCount,
    };
  }
}
