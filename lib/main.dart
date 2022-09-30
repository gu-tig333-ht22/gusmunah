import 'package:flutter/material.dart';

import 'package:localstorage/localstorage.dart';
import 'package:todoapp/AddTask.dart';

import 'HomeScreen.dart';
import 'Model.dart';

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

