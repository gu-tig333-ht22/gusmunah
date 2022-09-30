class TodoItem {
  String title;
  bool done;

  TodoItem({required this.title, required this.done});

  toJSONEncodable() {
    Map<String, dynamic> m = Map();

    m['title'] = title;
    m['done'] = done;

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
