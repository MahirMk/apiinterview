import 'package:apiinterview/views/pages/ApiInterview.dart';
import 'package:apiinterview/views/pages/LoginWithFacebook.dart';
import 'package:apiinterview/views/pages/LoginWithPhone.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home:  ApiInterview()
    );
  }
}