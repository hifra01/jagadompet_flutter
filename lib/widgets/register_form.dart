import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jagadompet_flutter/utils/firebase_utils.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                label: Text('Nama lengkap'),
                border: OutlineInputBorder(),
              ),
              controller: _fullNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Mohon masukkan nama Anda';
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
                label: Text('E-mail'),
                border: OutlineInputBorder(),
              ),
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'E-mail tidak boleh kosong';
                } else if (!EmailValidator.validate(value)) {
                  return 'Format e-mail tidak valid';
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
                } else if (value.length < 6) {
                  return 'Password harus memiliki panjang minimal 6 karakter';
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
                label: Text('Konfirmasi Password'),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              controller: _confirmPasswordController,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value != _passwordController.text) {
                  return 'Konfirmasi password tidak sesuai';
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
                String fullName = _fullNameController.text;
                String email = _emailController.text;
                String password = _passwordController.text;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sedang membuat akun...'),
                  ),
                );
                try {
                  await _auth.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  await userFirstTimeSetup(fullName, email);
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
            child: const Text('REGISTER'),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(inputWidth, inputHeight),
            ),
          )
        ],
      ),
    );
  }
}
