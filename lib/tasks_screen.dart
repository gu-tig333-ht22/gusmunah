import 'dart:js';

import 'package:flutter/material.dart';
import 'package:test/Widgets/todoitems.dart';

class TasksScreen extends StatelessWidget {
  get fontsize => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.stream,
                ),
                SizedBox(
                  height: 20,
                  width: double.infinity,
                ),
                Padding(padding: const EdgeInsets.only(left: 60, bottom: 20)),
                Text(
                  "Todo List",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return TodoItem();
            },
            itemCount: 6,
          ))
        ],
      ),
    );
  }
}
