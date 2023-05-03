import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'task-create.dart';
import 'task-list.dart';
import 'user-register.dart';
import 'user-login.dart';

const firebaseConfig = FirebaseOptions(
    apiKey: "AIzaSyAt3a4D3cevY9xGo-eSZ1UA_TEDltav0Ss",
    authDomain: "task-list-24880.firebaseapp.com",
    projectId: "task-list-24880",
    storageBucket: "task-list-24880.appspot.com",
    messagingSenderId: "256954399505",
    appId: "1:256954399505:web:95db3a5dd325cc8d45eab0");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, //desativa o banner de debug
        initialRoute: '/user-login',
        routes: {
          '/task-create': (context) => TaskCreatePage(),
          '/task-list': (context) => TaskListPage(),
          '/user-register': (context) => UserRegisterPage(),
          '/user-login': (context) => UserLoginPage(),
        });
  }
}
