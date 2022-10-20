class TodoItem {
  String id;
  String title;
  bool done;

  TodoItem({required this.title, required this.done,required this.id});

  toJSONEncodable() {
    Map<String, dynamic> m = Map();
    m['title'] = title;
    m['done'] = done;
    m['id'] = id;

    return m;
  }
}

class TodoList {
  List<TodoItem> items = [];

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}
