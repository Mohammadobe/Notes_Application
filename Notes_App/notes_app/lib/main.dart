import 'package:flutter/material.dart';
import 'package:notes_app/Screens/Home.dart';
import 'package:notes_app/Screens/Signup.dart';
import 'package:notes_app/Screens/Success.dart';
import 'package:notes_app/notes/Add.dart';
import 'package:notes_app/notes/Edit.dart';
import 'Screens/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course PHP Rest API',
      initialRoute: sharedPref.getString("id") == null ?"Login" :"Home",
      routes: {
        "Login": (context) => Login(),
        "Signup": (context) => Signup(),
        "Home": (context) => Home(),
        "Success": (context) => Success(),
        "Add": (context) => addNote(),
        "Edit": (context) => editNote(),
      }
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}