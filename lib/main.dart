import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/firebase_options.dart';
import 'package:to_do_app/views/auth/login_screen.dart';
import 'package:to_do_app/views/auth/signup_screen.dart';
import 'package:to_do_app/views/home/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do App',
      theme: ThemeData(
          useMaterial3: true,
          primaryColor: Colors.indigo,
          primarySwatch: Colors.indigo),
      home: _auth.currentUser != null ? HomeScreen() : LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
