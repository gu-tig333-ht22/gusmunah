import 'package:flutter/cupertino.dart';
import 'package:todoapp/Model/Model.dart';

class ListController extends ChangeNotifier{
  final TodoList list = TodoList();
  void refresh(){
    notifyListeners();
  }

  void addItem(TodoItem item) {
    list.items.add(item);
    notifyListeners();
  }

  void toggleCheck(TodoItem todoItem,int index,bool status){
    todoItem.done=status;
    list.items[index] = todoItem;
    notifyListeners();
  }
  void delete(int index){
    list.items.removeAt(index);
    notifyListeners();
  }
}