import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class TodoApi{
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
      log(e.toString());
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