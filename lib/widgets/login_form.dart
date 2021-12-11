import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  bool _hidePassword = true;
  bool _isLoginDisabled = false;

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

  void _doLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoginDisabled = true;
      });
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
      } on FirebaseException catch (e) {
        setState(() {
          _isLoginDisabled = false;
        });
        String errorMessage = e.message ?? 'Terjadi kesalahan';
        final snackBar = SnackBar(
          content: Text(errorMessage),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _showPassword = _hidePassword
        ? const Icon(Icons.visibility)
        : const Icon(Icons.visibility_off);
    return Form(
      key: _formKey,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text('E-mail'),
              ),
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'E-mail tidak boleh kosong';
                }
              },
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: InputDecoration(
                label: const Text('Password'),
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                  icon: _showPassword,
                ),
              ),
              obscureText: _hidePassword,
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password tidak boleh kosong';
                }
              },
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoginDisabled ? null : _doLogin,
                child: _isLoginDisabled
                    ? const CircularProgressIndicator()
                    : const Text('LOGIN'),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(double.infinity, 48),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
