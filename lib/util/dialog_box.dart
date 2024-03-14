import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/my_buttons.dart';

class DialogBox extends StatelessWidget {
  final controller;

  VoidCallback onsave;
  VoidCallback oncancel;
  DialogBox({
    super.key, 
    required this.controller,
    required this.onsave,
    required this.oncancel,
    });

  @override 
    Widget build(BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.deepPurpleAccent[300],
        content: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "enter a task",
                ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              MyButton(text: "save", onPressed: onsave),
              const SizedBox(width: 8),
              MyButton(text: "cancel", onPressed: oncancel),
         ]
         ,)
          ],)
          ),
      );
    }
}