import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Controller/ListController.dart';

import 'Component/my_text_field.dart';
import 'HomeScreen.dart';
import 'Model/Model.dart';
import 'Component/component.dart';

class AddTask extends StatefulWidget {
  TodoList list = TodoList();
  AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final LocalStorage storage = LocalStorage('todo_app.json');
  TextEditingController controller = TextEditingController();

  void _save(BuildContext context)async {
    try{
      if (controller.value.text.isNotEmpty) {
        await Provider.of<ListController>(context,listen: false).addTask("todos", {'title':controller.value.text,'done':false}, context);
        const snackBar = SnackBar(
          backgroundColor: Colors.green,
          content: Text('Task Added Successfully'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
      } else {
        const snackBar = SnackBar(
          content: Text('Please enter the any task'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }catch(e){
      log(e.toString());
      controller.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    double HEIGHT=MediaQuery.of(context).size.height;
    double WIDTH=MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: primaryColor,
                height: 56,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const HomePage()));
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                      const Text(
                        'TIG169 TODO',
                        style: TextStyle(
                          fontSize: 30,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                        ),
                      ),
                      const Text(''),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: HEIGHT*0.05,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: TextField(
                  controller: controller,
                  decoration: decoration.copyWith(labelText: "What to do?"),
                  onEditingComplete: (){
                    //_save(context);
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  _save(context);
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
      ),
    );
  }
}
