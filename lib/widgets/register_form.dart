import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

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
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints.tight(Size(inputWidth, inputHeight)),
          child: TextFormField(
            decoration: const InputDecoration(
              label: Text('Nama lengkap'),
              border: OutlineInputBorder(),
            ),
            controller: _fullNameController,
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
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('REGISTER'),
          style: ElevatedButton.styleFrom(
              fixedSize: Size(inputWidth, inputHeight)),
        )
      ],
    );
  }
}
