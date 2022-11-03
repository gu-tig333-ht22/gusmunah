import 'package:flutter/cupertino.dart';
import 'package:todoapp/Model/Model.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class ListController extends ChangeNotifier{
  final TodoList list = TodoList();
  final apiKey="0160bd86-6528-4059-bbab-28469bd90fc1";
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
  void deleteItem(int index){
    list.items.removeAt(index);
    notifyListeners();
  }

  Future<void> addTask(String url,dynamic body,BuildContext context)async{
    log(url);
    try {
      var headers = {'Content-Type': "application/json"};
      var response = await post(body,"$url?key=$apiKey",headers);
      log('Add task: Response status: ${response!.statusCode}');
      if (response.statusCode == 200) {
      } else {
        var decoded = jsonDecode(response.body);
        throw Exception(decoded);
      }
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(child: Text("Unable to add task",style: TextStyle(color: Colors.white),),),backgroundColor: Colors.red,));
      throw Exception(e);
    }
  }

  Future<dynamic> getTask(String url,BuildContext context)async{
    log(url);
    try {
      var headers = {'Content-Type': "application/json"};
      var response = await get("$url?key=$apiKey",headers);
      log('Get task: Response status: ${response!.statusCode}');
      if (response.statusCode == 200) {
        var decoded = jsonDecode(response.body);
        log(decoded.toString());
        return decoded;
      } else {
        var decoded = jsonDecode(response.body);
        throw Exception(decoded);
      }
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(child: Text("Unable to get task",style: TextStyle(color: Colors.white),),),backgroundColor: Colors.red,));
      throw Exception(e);
    }
  }
  Future<dynamic> updateTask(String url,dynamic body,BuildContext context)async{
    try {
      var headers = {'Content-Type': "application/json"};
      var response = await put(body,"$url?key=$apiKey",headers);
      log('Update task: Response status: ${response!.statusCode}');
      if (response.statusCode == 200) {
        var decoded = jsonDecode(response.body);
        log(decoded.toString());
        return decoded;
      } else {
        var decoded = jsonDecode(response.body);
        throw Exception(decoded);
      }
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(child: Text("Unable to update task",style: TextStyle(color: Colors.white),),),backgroundColor: Colors.red,));
      throw Exception(e);
    }
  }
  Future<dynamic> deleteTask(String url,BuildContext context)async{
    log(url);
    try {
      var headers = {'Content-Type': "application/json"};
      var response = await delete("$url?key=$apiKey",headers);
      log('Delete task: Response status: ${response!.statusCode}');
      if (response.statusCode == 200) {
        var decoded = jsonDecode(response.body);
        log(decoded.toString());
        return decoded;
      } else {
        var decoded = jsonDecode(response.body);
        throw Exception(decoded);
      }
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(child: Text("Unable to delete task",style: TextStyle(color: Colors.white),),),backgroundColor: Colors.red,));
      throw Exception(e);
    }
  }
  final String baseUrl="https://todoapp-api.apps.k8s.gu.se/";

  Future<http.Response?> post(var body,String urlLocation,var headers)async{
    try{
      var url = Uri.parse("$baseUrl$urlLocation");
      log(url.toString());
      var response = await http.post(url, body: jsonEncode(body),headers: headers);
      if (kDebugMode) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
      return response;
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
  Future<http.Response?> get(String urlLocation,var headers)async{
    try{
      var url = Uri.parse("$baseUrl$urlLocation");
      log(url.toString());
      var response = await http.get(url,headers: headers);
      return response;
    }catch(e){
      log(e.toString());
    }
  }
  Future<http.Response?> put(var body,String urlLocation,var headers)async{
    try{
      var url = Uri.parse("$baseUrl$urlLocation");
      log(url.toString());
      var response = await http.put(url, body: jsonEncode(body),headers: headers);
      if (kDebugMode) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
      return response;
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
  Future<http.Response?> delete(String urlLocation,var headers)async{
    try{
      var url = Uri.parse("$baseUrl$urlLocation");
      log(url.toString());
      var response = await http.delete(url,headers: headers);
      return response;
    }catch(e){
      log(e.toString());
    }
  }
}