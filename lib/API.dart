import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/API/myapi.dart';

class API {
  final _myApi=MyApi();
  final apiKey="0160bd86-6528-4059-bbab-28469bd90fc1";

  Future<void> addTask(String url,dynamic body,BuildContext context)async{
    log(url);
    try {
      var headers = {'Content-Type': "application/json"};
      var response = await _myApi.post(body,"$url?key=$apiKey",headers);
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
      var response = await _myApi.get("$url?key=$apiKey",headers);
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
      var response = await _myApi.put(body,"$url?key=$apiKey",headers);
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
      var response = await _myApi.delete("$url?key=$apiKey",headers);
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
}