import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';

final LocalStorage storage = LocalStorage('todo_app.json');
bool initialized = false;
TextEditingController controller = TextEditingController();


