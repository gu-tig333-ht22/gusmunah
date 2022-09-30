import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:todoapp/variables.dart';

import 'HomeScreen.dart';
import 'Model.dart';

class AddTask extends StatefulWidget {
  TodoList list = TodoList();
  AddTask(this.list, {Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  void _save() {
    setState(() {
      if (controller.value.text.isNotEmpty) {
        _addItem(controller.value.text);
        const snackBar = SnackBar(
          content: Text('Task Added Successfully'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        const snackBar = SnackBar(
          content: Text('Please enter the any task'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });

    controller.clear();
  }

  _addItem(String title) {
    setState(() {
      final item = TodoItem(title: title, done: false);
      list.items.add(item);
      _saveToStorage();
    });
  }

  _saveToStorage() {
    setState(() {
      storage.setItem('todos', list.toJSONEncodable());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.grey,
              height: 56,
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                          // Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_ios)),
                    const Text(
                      'TIG169 TODO',
                      style: TextStyle(
                        fontSize: 30,
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                      ),
                    ),
                    const Text(''),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.black,
                ),
              ),
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: 'What to do?',
                  ),
                  onEditingComplete: _save,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _save();
              },
              child: Container(
                margin: const EdgeInsets.only(left: 140, top: 40),
                child: Center(
                  child: Row(
                    children: const [
                      Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.black,
                      ),
                      Text(
                        'ADD',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
