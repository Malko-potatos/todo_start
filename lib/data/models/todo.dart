import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String? id; // id는 선택적입니다.
  late final String taskName;
  final String taskDesc;
  final String taskTag;
  final String taskDate;

  Todo({
    this.id, // 선택적
    required this.taskName,
    required this.taskDesc,
    required this.taskTag,
    required this.taskDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'taskName': taskName,
      'taskDesc': taskDesc,
      'taskTag': taskTag,
      'taskDate': taskDate,
    };
  }

  factory Todo.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Todo(
      id: doc.id, // 문서의 id를 추가합니다.
      taskName: data['taskName'] ?? '',
      taskDesc: data['taskDesc'] ?? '',
      taskTag: data['taskTag'] ?? '',
      taskDate: data['taskDate'] ?? '',
    );
  }
  @override
  String toString() {
    return 'Todo - taskName: $taskName, taskDesc: $taskDesc, taskTag: $taskTag, taskDate: $taskDate,taskId: $id';
  }
}
