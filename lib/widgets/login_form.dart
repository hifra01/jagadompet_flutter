import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double inputWidth = MediaQuery.of(context).size.width * 0.7;
    const double inputHeight = 50;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints.tight(Size(inputWidth, inputHeight)),
            child: TextFormField(
              decoration: const InputDecoration(
                label: Text('E-mail'),
                border: OutlineInputBorder(),
              ),
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'E-mail tidak boleh kosong';
                }
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ConstrainedBox(
            constraints: BoxConstraints.tight(Size(inputWidth, inputHeight)),
            child: TextFormField(
              decoration: const InputDecoration(
                label: Text('Password'),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password tidak boleh kosong';
                }
              },
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                String email = _emailController.text;
                String password = _passwordController.text;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Mencoba login...'),
                  ),
                );
                try {
                  await _auth.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  Navigator.pushReplacementNamed(context, '/home');
                } on FirebaseAuthException catch (e) {
                  String errorMessage = e.message ?? 'Terjadi kesalahan';
                  final snackBar = SnackBar(
                    content: Text(errorMessage),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }
            },
            child: const Text('LOGIN'),
            style: ElevatedButton.styleFrom(
                fixedSize: Size(inputWidth, inputHeight)),
          )
        ],
      ),
    );
  }
}
