import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jagadompet_flutter/pages/add_income_page.dart';
import 'package:jagadompet_flutter/pages/add_outcome_page.dart';
import 'package:jagadompet_flutter/pages/detail_income_page.dart';
import 'package:jagadompet_flutter/pages/detail_outcome_page.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String initialPath = _auth.currentUser != null ? '/home' : '/login';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JagaDompet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/addoutcome': (context) => const AddOutcomePage(),
        '/addincome': (context) => const AddIncomePage(),
        '/detailoutcome': (context) => const DetailOutcomePage(),
        '/detailincome': (context) => const DetailIncomePage(),
      },
      initialRoute: initialPath,
    );
  }
}
