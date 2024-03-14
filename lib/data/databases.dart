import 'package:hive_flutter/hive_flutter.dart';

class TodoDataBase {
  List ToDoList = [];

  final _myBox = Hive.box('todoList');

  void createInitialData() {
    ToDoList = [
      ["create course video", false],
      ["create course video", false],
    ];
  }

  void loadData() {
    ToDoList = _myBox.get("todoList");
  }

  void updateDataBase() {
    _myBox.put("todoList", ToDoList);
  }
}
