import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jagadompet_flutter/pages/home_page.dart';
import 'package:jagadompet_flutter/pages/login_page.dart';
import 'package:jagadompet_flutter/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JagaDompet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
      },
      initialRoute: '/login',
    );
  }
}