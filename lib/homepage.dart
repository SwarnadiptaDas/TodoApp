import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/databases.dart';
import 'package:flutter_application_1/my%20drawer.dart';
import 'package:flutter_application_1/util/dialog_box.dart';
import 'package:flutter_application_1/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, this.toDoList});
  List<dynamic>? toDoList;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('todoList');
  TodoDataBase db = TodoDataBase();

  @override
  void initState() {
    if (_myBox.get("todoList") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.ToDoList[index][1] = !db.ToDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.ToDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
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
  }

  void deleteTask(int index) {
    final finalList = widget.toDoList ?? db.ToDoList;
    setState(() {
      finalList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyHeaderDrawer(),

      // backgroundColor: Colors.deepPurpleAccent[200],
      appBar: AppBar(
        title: Text('Todo Manager'),
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                widget.toDoList = db.ToDoList;
              });

              // db.ToDoList.where((element) => element[1] == false).toList();
            },
            child: Icon(Icons.refresh),
          ),
          SizedBox(width: 10),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: widget.toDoList?.length ?? db.ToDoList.length,
        itemBuilder: (context, index) {
          final finalList = widget.toDoList ?? db.ToDoList;
          return ToDoTile(
            taskName: finalList[index][0],
            taskCompleted: finalList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFuncton: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
