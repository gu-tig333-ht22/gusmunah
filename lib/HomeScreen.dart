import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:todoapp/variables.dart';

import 'AddTask.dart';
import 'Model.dart';

final TodoList list = TodoList();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  _toggleItem(TodoItem item) {
    setState(() {
      item.done = !item.done;
      _saveToStorage();
    });
  }

  _saveToStorage() {
    storage.setItem('todos', list.toJSONEncodable());
  }

  bool? selected;
  int num = 0;
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
        actions: [
          PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("show all todo"),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text("show active todo  "),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text("show completed"),
              ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              setState(() {
                num = 0;
              });
              print("My account menu is selected.");
            } else if (value == 1) {
              setState(() {
                selected = false;
                num = 1;
              });
              print("Settings menu is selected.");
            } else if (value == 2) {
              setState(() {
                num = 2;
                selected = true;
              });
              print("Logout menu is selected.");
            }
          }),
        ],
      ),
      body: Container(
          padding: const EdgeInsets.only(bottom: 10, top: 15),
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
                    if (num == 2) {
                      return list.items[index].done == true
                          ? Column(
                              children: [
                                Container(
                                  height: 80,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                              checkColor: Colors.white,
                                              value: list.items[index].done,
                                              onChanged: (_) {
                                                _toggleItem(list.items[index]);
                                              }),
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              maxLines: 2,
                                              list.items[index].title,
                                              style: TextStyle(
                                                  decoration:
                                                      list.items[index].done ==
                                                              true
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : TextDecoration.none,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(right: 20),
                                          child: IconButton(
                                            icon: const Icon(
                                                Icons.cancel_outlined),
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
                                const Divider(
                                  height: 0.5,
                                  color: Colors.black,
                                ),
                              ],
                            )
                          : Text('');
                    } else if (num == 1) {
                      return list.items[index].done == false
                          ? Column(
                              children: [
                                Container(
                                  height: 80,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                              checkColor: Colors.white,
                                              value: list.items[index].done,
                                              onChanged: (_) {
                                                _toggleItem(list.items[index]);
                                              }),
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              maxLines: 2,
                                              list.items[index].title,
                                              style: TextStyle(
                                                  decoration:
                                                      list.items[index].done ==
                                                              true
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : TextDecoration.none,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(right: 20),
                                          child: IconButton(
                                            icon: const Icon(
                                                Icons.cancel_outlined),
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
                                const Divider(
                                  height: 0.5,
                                  color: Colors.black,
                                ),
                              ],
                            )
                          : Text('');
                    } else {
                      return Column(
                        children: [
                          Container(
                            height: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        checkColor: Colors.white,
                                        value: list.items[index].done,
                                        onChanged: (_) {
                                          _toggleItem(list.items[index]);
                                        }),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        maxLines: 2,
                                        list.items[index].title,
                                        style: TextStyle(
                                            decoration:
                                                list.items[index].done == true
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
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
                          const Divider(
                            height: 0.5,
                            color: Colors.black,
                          ),
                        ],
                      );
                    }
                  });
            },
          )),
    );
  }
}
