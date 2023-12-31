// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:todo_start/data/models/todo.dart';
import 'package:todo_start/data/service/firebase_backend.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late Todo new_todo;
  late TextEditingController todoNameController;
  late TextEditingController todoDescController;
  String tag = '업무';
  String date = '';
  late DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    todoNameController = TextEditingController();
    todoDescController = TextEditingController();
  }

  void _showDatePicker() async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2030));
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: todoNameController,
              decoration: InputDecoration(labelText: '제목'),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: todoDescController,
              decoration: InputDecoration(labelText: '내용'),
            ),
            const SizedBox(
              height: 15,
            ),
            DropdownButtonFormField<String>(
              value: tag,
              decoration: InputDecoration(labelText: '태그'),
              onChanged: (newValue) {
                setState(() {
                  tag = newValue!;
                });
              },
              items: ['업무', '공부', '운동', '기타'].map(
                (tag) {
                  return DropdownMenuItem(value: tag, child: Text(tag));
                },
              ).toList(),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                _showDatePicker();
                date = selectedDate!.toString().substring(0, 10);
              },
              child: Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(selectedDate!.toString().substring(0, 10))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                new_todo = Todo(
                    taskName: todoNameController.text,
                    taskDesc: todoDescController.text,
                    taskTag: tag,
                    taskDate: date);
                addTodo(new_todo);
              },
              child: Text('ADD'),
            ),
          ],
        ),
      ),
    );
  }
}
