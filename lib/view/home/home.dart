import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_start/view/home/todo_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _logout(BuildContext context) async {
    try {
      await _auth.signOut();
      // 로그아웃 성공 후 처리할 로직을 작성하세요.
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login', // 로그인 페이지로 이동합니다.
        (route) => false, // 이전 경로들을 모두 제거합니다.
      );
    } catch (e) {
      // 로그아웃 실패 시 예외 처리를 할 수 있습니다.
      print('Logout failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(centerTitle: true, title: const Text("Modu Todo"), actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            _logout(context);
          },
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
      extendBody: true,
      body: TodoList(),
    );
  }
}
