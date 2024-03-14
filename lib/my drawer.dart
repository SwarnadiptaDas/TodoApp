import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/databases.dart';
import 'package:flutter_application_1/homepage.dart';
import 'package:flutter_application_1/util/dialog_box.dart';
import 'package:hive/hive.dart';

class MyHeaderDrawer extends StatefulWidget {
  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  final _controller = TextEditingController();
  TodoDataBase db = TodoDataBase();
  final _myBox = Hive.box('todoList');

  void saveNewTask() {
    setState(() {
      db.ToDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  void initState() {
    if (_myBox.get("todoList") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add your drawer content here
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
            ),
            child: Row(children: [
              Icon(Icons.book, size: 100),
              Text(
                'Todo Manager',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
          ),
          ListTile(
            title: Text(
              'Create New',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              //  HomePage().

              showDialog(
                context: context,
                builder: (context) {
                  return DialogBox(
                    controller: _controller,
                    onsave: saveNewTask,
                    oncancel: () => Navigator.of(context).pop(),
                  );
                },
              );
              // Add your drawer item tap logic here
            },
          ),
          ListTile(
            title: Text(
              'Active Task',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    toDoList:
                        db.ToDoList.where((element) => element[1] == false)
                            .toList(),
                  ),
                ),
              );
              // Add your drawer item tap logic here
            },
          ),
          ListTile(
            title: const Text(
              'Completed Task',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    toDoList: db.ToDoList.where((element) => element[1] == true)
                        .toList(),
                  ),
                ),
              );
              // Add your drawer item tap logic here
            },
          ),
          // Add more ListTile widgets for additional items
        ],

        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Container(
        //         margin: EdgeInsets.only(bottom: 10),
        //         height: 70,
        //         decoration: BoxDecoration(),
        //         child: Icon(Icons.menu))
        //   ],
        // ),
      ),
    );
  }
}
