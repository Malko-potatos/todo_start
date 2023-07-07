import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_start/data/models/todo.dart';

//home에서 'task' 콜렉션 안의 문서들을 조회
Stream<List<Todo>> getTodoList(FirebaseFirestore firestore) {
  //task라는 이름의 콜렉션을 찾아서, 스냅샷으로 받아서 해당
  //스냅샷안의 문서를 Todo 객체로 바꿔서 List<Todo>로 만듬
  return firestore.collection('task').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => Todo.fromDocument(doc)).toList();
  });
}

//Todo 문서를 추가
Future<void> addTodo(Todo todo) async {
  Map<String, dynamic> todoJson = todo.toJson();

  DocumentReference doc_ref =
      await FirebaseFirestore.instance.collection('task').add(todoJson);
  String todo_id = doc_ref.id;
  await FirebaseFirestore.instance
      .collection('task')
      .doc(todo_id)
      .update({'id': todo_id});
}

Future<void> updateTodoById(Todo todo) async {
  FirebaseFirestore.instance
      .collection('task')
      .doc(todo.id)
      .update(todo.toJson())
      .then((_) {
    print('Document updated successfully');
  }).catchError((error) {
    print('Error updating document: $error');
  });
}

Future<void> deleteTodoById(String id) async {
  try {
    await FirebaseFirestore.instance.collection('task').doc(id).delete();
    print('Todo deleted successfully');
  } catch (e) {
    throw Exception('Failed to delete Todo: $e');
  }
}
