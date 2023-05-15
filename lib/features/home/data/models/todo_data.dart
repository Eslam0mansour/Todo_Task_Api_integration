// {
//     "id": 1,
//     "name": "aaaaaaaaaaaa",
//     "description": "aaaaaaaaaaaaaaaaaa",
//     "isCompleted": false,
//     "createdOn": "2023-05-15T00:09:30.850892"
// }

class TodoData {
  int? id;
  String? name;
  String? description;
  bool? isCompleted;
  DateTime? createdOn;

  TodoData({
    this.id,
    this.name,
    this.description,
    this.isCompleted,
    this.createdOn,
  });

  factory TodoData.fromJson(Map<String, dynamic> json) => TodoData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        isCompleted: json["isCompleted"],
        createdOn: DateTime.parse(json["createdOn"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "isCompleted": isCompleted,
        "createdOn": createdOn,
      };
}