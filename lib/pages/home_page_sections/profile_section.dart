import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileSection extends StatefulWidget {
  final User? currentUser;
  const ProfileSection({Key? key, required this.currentUser}) : super(key: key);

  @override
  _ProfileSectionState createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          widget.currentUser!.displayName.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
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
    );
  }
}
