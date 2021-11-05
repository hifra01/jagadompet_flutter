import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jagadompet_flutter/widgets/profile_name.dart';

class ProfileSection extends StatefulWidget {
  final User? currentUser;
  const ProfileSection({Key? key, required this.currentUser}) : super(key: key);

  @override
  _ProfileSectionState createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: const Text(
            'Profil',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                const Image(
                  image: AssetImage('assets/images/user.png'),
                  width: 120,
                ),
                const SizedBox(
                  height: 32,
                ),
                ProfileName(currentUser: widget.currentUser),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.currentUser!.email.toString(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 32,
                ),
                TextButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Peringatan'),
                      content: const Text('Apakah Anda yakin ingin keluar?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('BATAL'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text('LOG OUT'),
                        ),
                      ],
                    ),
                  ),
                  style: TextButton.styleFrom(primary: Colors.red),
                  child: const Text(
                    'LOG OUT',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
