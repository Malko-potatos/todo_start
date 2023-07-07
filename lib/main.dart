import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_start/view/add_task/add_task.dart';
import 'package:todo_start/view/auth/sign_in.dart';
import 'firebase_options.dart';
import 'view/home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return MaterialApp(
      title: 'Todo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.yellow),
      routes: {
        '/add': (context) => AddTask(),
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginPage(),
      },
      home: StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 인증 상태 확인 중이므로 로딩 스피너 또는 로딩 페이지를 표시할 수 있습니다.
            return CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              // 사용자가 인증된 경우 홈 페이지로 이동합니다.
              return HomeScreen();
            } else {
              // 사용자가 인증되지 않은 경우 로그인 페이지로 이동합니다.
              return AnimatedSplashScreen(
                  duration: 3000,
                  splash: Image.asset('assets/images/modulabs.png'),
                  nextScreen: LoginPage());
            }
          }
        },
      ),
    );
  }
}
