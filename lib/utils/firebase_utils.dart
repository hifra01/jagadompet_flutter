import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userFirstTimeSetup(String fullName, String email) async {
  CollectionReference users = FirebaseFirestore.instance.collection('profile');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  users.doc(uid).set({'fullName': fullName, 'email': email});
  return;
}