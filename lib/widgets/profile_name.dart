import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class ProfileName extends StatefulWidget {
  final User? currentUser;
  const ProfileName({Key? key, required this.currentUser}) : super(key: key);

  @override
  _ProfileNameState createState() => _ProfileNameState();
}

class _ProfileNameState extends State<ProfileName> {
  late DocumentReference _profileRef;

  @override
  void initState() {
    super.initState();
    _profileRef = FirebaseFirestore.instance
        .collection('profile')
        .doc(widget.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle nameStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w900,
    );
    return FutureBuilder(
      future: _profileRef.get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Terjadi kesalahan',
            style: nameStyle,
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map item = snapshot.data!.data() as Map<String, Object?>;
          return Text(
            item['name'],
            style: nameStyle,
          );
        }

        return SkeletonAnimation(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            height: 18,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black26,
            ),
          ),
        );
      },
    );
  }
}
