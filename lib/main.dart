import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:localstorage/localstorage.dart';
import 'package:todoapp/AddTask.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

final TodoList list = TodoList();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

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

class _MyHomePageState extends State<HomePage> {
  final LocalStorage storage = LocalStorage('todo_app.json');
  bool initialized = false;
  TextEditingController controller = TextEditingController();

  _toggleItem(TodoItem item) {
    setState(() {
      item.done = !item.done;
      _saveToStorage();
    });
  }

  _saveToStorage() {
    storage.setItem('todos', list.toJSONEncodable());
  }

  _clearStorage(String title) async {
    await list.items.remove(title);

    setState(() {
      list.items = storage.getItem('todos') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade400,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTask(list)));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 10,
        shadowColor: Colors.white,
        backgroundColor: Colors.grey.shade400,
        centerTitle: true,
        title: const Text(
          'TIG169 TODO',
          style: TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.normal,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 15),
          constraints: const BoxConstraints.expand(),
          child: FutureBuilder(
            future: storage.ready,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!initialized) {
                var items = storage.getItem('todos');

                if (items != null) {
                  list.items = List<TodoItem>.from(
                    (items as List).map(
                      (item) => TodoItem(
                        title: item['title'],
                        done: item['done'],
                      ),
                    ),
                  );
                }

                initialized = true;
              }

              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 10,
                      shadowColor: Colors.white,
                      child: Container(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                    value: list.items[index].done,
                                    onChanged: (_) {
                                      _toggleItem(list.items[index]);
                                    }),
                                Text(list.items[index].title),
                              ],
                            ),
                            Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: IconButton(
                                  icon: const Icon(Icons.cancel_outlined),
                                  onPressed: () {
                                    //_clearStorage(list.items[index].title);
                                    setState(() {
                                      list.items.removeAt(index);
                                    });
                                    _saveToStorage();
                                  },
                                )),
                          ],
                        ),
                      ),
                    );
                  });
            },
          )),
    );
  }
}
