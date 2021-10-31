import 'package:flutter/material.dart';
import 'package:jagadompet_flutter/widgets/app_logo.dart';
import 'package:jagadompet_flutter/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 128,
              ),
              AppLogo(
                size: 36,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(
                height: 64,
              ),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const LoginForm(),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'atau',
                style: TextStyle(fontSize: 12),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
                child: const Text(
                  'Buat akun baru',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
