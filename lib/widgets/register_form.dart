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
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;
  bool _isRegisterDisabled = false;

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

  void _doRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isRegisterDisabled = true;
      });
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
      } on FirebaseException catch (e) {
        _isRegisterDisabled = false;
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
    Widget _showConfirmPassword = _hideConfirmPassword
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
                label: Text('Nama lengkap'),
              ),
              controller: _fullNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Mohon masukkan nama Anda';
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('E-mail'),
              ),
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'E-mail tidak boleh kosong';
                } else if (!EmailValidator.validate(value)) {
                  return 'Format e-mail tidak valid';
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
                } else if (value.length < 6) {
                  return 'Panjang password minimal 6 karakter';
                }
              },
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: InputDecoration(
                label: const Text('Konfirmasi Password'),
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      _hideConfirmPassword = !_hideConfirmPassword;
                    });
                  },
                  icon: _showConfirmPassword,
                ),
              ),
              obscureText: _hideConfirmPassword,
              controller: _confirmPasswordController,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value != _passwordController.text) {
                  return 'Konfirmasi password tidak sesuai';
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
                onPressed: _isRegisterDisabled ? null : _doRegister,
                child: _isRegisterDisabled
                    ? const CircularProgressIndicator()
                    : const Text('REGISTER'),
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
