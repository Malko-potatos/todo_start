import 'package:flutter/material.dart';
import 'package:todo_start/data/models/todo.dart';
import 'package:todo_start/data/service/firebase_backend.dart';
import 'package:todo_start/view/modified_task/modifed_task.dart';

import '../../../utils/category_color.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;

  const TodoListItem({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id.toString()), // 고유한 키로 아이템을 식별합니다.
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        deleteTodoById(todo.id.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Todo deleted'),
          ),
        );
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurStyle: BlurStyle.normal,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: GestureDetector(
          onTap: (() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditTask(
                  edit_todo: todo,
                ),
              ),
            );
          }),
          child: ListTile(
              isThreeLine: true,
              leading: Container(
                width: 50,
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.task_rounded,
                  color: select_color_from_category(todo.taskTag),
                  size: 50,
                ),
              ),
              title: Text(
                todo.taskName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                todo.taskDesc,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              trailing: Text(
                todo.taskDate,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              )),
        ),
      ),
    );
  }
}
