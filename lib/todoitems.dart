import 'package:flutter/material.dart';

class TodoItem extends StatefulWidget {
  @override
  State createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TodoItem> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Gå till gymmet",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: Checkbox(
        value: this.selected,
        checkColor: Colors.black,
        activeColor: Colors.yellow,
        // inactiveColor: Colors.grey,
        // disabledColor: Colors.yellow,
        onChanged: (value) => this.selected = !this.selected,
      ),
    );
  }
}
