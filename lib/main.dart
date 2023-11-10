// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasecourse/auth/login.dart';
import 'package:firebasecourse/auth/signup.dart';
import 'package:firebasecourse/homepage.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print(
            '""""""""""""""""""User is currently signed out!""""""""""""""""""');
      } else {
        print('""""""""""""""""""""User is signed in!""""""""""""""""""""');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null ? Login() : Homepage(),
      routes: {
        "signup": (context) => SignUp(),
        "login": (context) => Login(),
        "homepage": (context) => Homepage(),
      },
    );
  }
}
