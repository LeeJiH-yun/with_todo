class Todo {
  late int? id;
  late String desc;

  Todo({this.id, required this.desc});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'desc': desc,
    };
  }

  Todo.fromMap(Map<dynamic, dynamic>? map) {
    id = map?['id'];
    desc = map?['desc'];
  }
}
