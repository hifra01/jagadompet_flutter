import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

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
    return Column(
      children: [
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
          height: 32,
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('LOGIN'),
          style: ElevatedButton.styleFrom(
              fixedSize: Size(inputWidth, inputHeight)),
        )
      ],
    );
  }
}
