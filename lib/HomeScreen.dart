import 'dart:developer';

import 'package:async/async.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/API.dart';
import 'package:todoapp/Controller/ListController.dart';

import 'AddTask.dart';
import 'Model/Model.dart';
import 'Component/component.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {

  final int _count = 10;
  late EasyRefreshController _controller;
  final LocalStorage storage = LocalStorage('todo_app.json');
  bool initialized = false;
  TextEditingController controller = TextEditingController();
  AsyncMemoizer asyncMemoizer=AsyncMemoizer();
  final myApi=API();
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool? selected;
  int num = 0;

  @override
  Widget build(BuildContext context) {
    double HEIGHT=MediaQuery.of(context).size.height;
    double WIDTH=MediaQuery.of(context).size.width;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey.shade400,
          onPressed: () async{
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddTask()));
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.white,
          backgroundColor: primaryColor,
          centerTitle: true,
          title: const Text(
            'TIG169 TODO',
            style: TextStyle(
              fontSize: 30,
              fontStyle: FontStyle.normal,
              color: Colors.white,
            ),
          ),
          actions: [
            menu(),
          ],
        ),
        body: EasyRefresh(
          controller: _controller,
          header: const ClassicHeader(),
          footer: const ClassicFooter(),
          onRefresh: () async {
            asyncMemoizer= AsyncMemoizer();
            setState(() {});
            _controller.finishRefresh();
            _controller.resetFooter();
          },
          onLoad: () async {
            await Future.delayed(const Duration(seconds: 1));
            if (!mounted) {
              return;
            }
            setState(() {});
            _controller.finishLoad(_count >= 20
                ? IndicatorResult.noMore
                : IndicatorResult.success);
          },
          child: Container(
            padding: const EdgeInsets.only(bottom: 10, top: 15),
            constraints: const BoxConstraints.expand(),
            child: FutureBuilder(
              future: myApi.getTask("todos", context),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData){
                  var items = List.from(snapshot.data).toList();
                  var listcontroller=Provider.of<ListController>(context,listen: false);
                  listcontroller.list.items = List<TodoItem>.from(
                    (items).map(
                          (item) => TodoItem(
                        title: item['title'],
                        done: item['done'],
                        id: item['id'],
                      ),
                    ),
                  );
                  listcontroller.list.items = listcontroller.list.items;
                  return listitem();
                }else if(snapshot.connectionState==ConnectionState.done&&snapshot.hasError){
                  return SizedBox(
                    width: WIDTH,
                    height: HEIGHT,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.grey,
                            size: WIDTH*0.1,
                          ),
                          Text(
                            "Unable to get task\nSwipe down to refresh",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                              fontSize: WIDTH*0.04
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }else{
                  return SpinKitCubeGrid(
                    size: WIDTH*0.1,
                    color: primaryColor,
                  );
                }
              },
            ),
          ),
        )
    );
  }

  listitem() {
    return Consumer<ListController>(
      builder: (context,listcontroller,child) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: listcontroller.list.items.length,
            itemBuilder: (BuildContext context, int index) {
              listcontroller.list.items[index] = listcontroller.list.items[index];
              if (num == 2) {
                return listcontroller.list.items[index].done == true
                    ? card(listcontroller.list.items[index].done, index)
                    : Text('');
              } else if (num == 1) {
                return listcontroller.list.items[index].done == false
                    ? card(listcontroller.list.items[index].done, index)
                    : Text('');
              } else {
                return card(listcontroller.list.items[index].done, index);
              }
            });
      }
    );
  }

  card(bool done, int index) {
    return Consumer<ListController>(
      builder: (context,listcontroller,widget) {
        return Column(
          children: [
            Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          value: done,
                          onChanged: (_) async{
                            try{
                              log(_.toString());
                              //_toggleItem(list.items[index]);
                              var body={'title':listcontroller.list.items[index].title,'done':_};
                              await myApi.updateTask("todos/${listcontroller.list.items[index].id}",body ,context);
                              listcontroller.toggleCheck(listcontroller.list.items[index],index,_!);
                            }catch(e){
                              log(e.toString());
                            }
                          }),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          listcontroller.list.items[index].title,
                          maxLines: 2,
                          style: TextStyle(
                              decoration: listcontroller.list.items[index].done == true
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: IconButton(
                        icon: const Icon(Icons.cancel_outlined),
                        onPressed: () async{
                          //_clearStorage(list.items[index].title);
                          try{
                            await myApi.deleteTask("todos/${listcontroller.list.items[index].id}", context);
                            listcontroller.delete(index);
                          }catch(e){
                            log(e.toString());
                          }
                         // _saveToStorage();
                        },
                      )
                  ),
                ],
              ),
            ),
            const Divider(
              height: 0.5,
              color: Colors.black,
            ),
          ],
        );
      }
    );
  }

  menu() {
    return PopupMenuButton(
      color: Colors.white,
        // add icon, by default "3 dot" icon
        // icon: Icon(Icons.book)
        itemBuilder: (context) {
        return [
        const PopupMenuItem<int>(
          value: 0,
          child: Text("show all todo"),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child: Text("show active todo  "),
        ),
        const PopupMenuItem<int>(
          value: 2,
          child: Text("show completed"),
        ),
      ];
    }, onSelected: (value) {
      if (value == 0) {
        setState(() {
          num = 0;
        });
        print("My account menu is selected.");
      } else if (value == 1) {
        setState(() {
          selected = false;
          num = 1;
        });
        print("Settings menu is selected.");
      } else if (value == 2) {
        setState(() {
          num = 2;
          selected = true;
        });
        print("Logout menu is selected.");
      }
    });
  }
}
