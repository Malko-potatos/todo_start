import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_start/data/service/firebase_backend.dart';

import '../../data/models/todo.dart';
import 'widget/todo_list_item.dart';

class TodoList extends StatefulWidget {
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    super.initState();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: StreamBuilder<List<Todo>>(
        stream: getTodoList(firestore),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('불러올 데이터가 없습니다.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return TodoListItem(todo: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}
