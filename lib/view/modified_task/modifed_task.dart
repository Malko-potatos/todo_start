import 'package:flutter/material.dart';
import 'package:todo_start/data/models/todo.dart';
import 'package:todo_start/data/service/firebase_backend.dart';

class EditTask extends StatefulWidget {
  final Todo edit_todo;
  const EditTask({Key? key, required this.edit_todo}) : super(key: key);

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController taskNameController;
  late TextEditingController taskDescController;
  late String taskDate;
  late String tag;
  String date = '';
  late DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    print(widget.edit_todo);
    super.initState();

    // 기존의 할일 정보를 가져와 초기값으로 설정합니다.
    taskNameController = TextEditingController(text: widget.edit_todo.taskName);
    taskDescController = TextEditingController(text: widget.edit_todo.taskDesc);
    tag = widget.edit_todo.taskTag;
    taskDate = widget.edit_todo.taskDate;
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescController.dispose();
    super.dispose();
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

  void updateTodo() {
    // 수정된 할일 정보를 저장하는 로직을 작성합니다.
    Todo updatedTodo = Todo(
      taskName: taskNameController.text,
      taskDesc: taskDescController.text,
      taskTag: tag,
      taskDate: taskDate,
      id: widget.edit_todo.id,
    );
    print('update :${updatedTodo}');

    updateTodoById(updatedTodo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: taskNameController,
              decoration: InputDecoration(
                labelText: '제목',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: taskDescController,
              decoration: InputDecoration(
                labelText: 'Task Description',
              ),
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
                updateTodo();
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
