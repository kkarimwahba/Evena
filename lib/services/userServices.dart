import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evena/models/users.dart';
import 'package:evena/screens/adminHome.dart';
import 'package:evena/screens/userHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final db = FirebaseFirestore.instance;

final FirebaseAuth _auth = FirebaseAuth.instance;

signup(UserBase user) {
  db.collection('users').add(user.tojson());
}

Future<void> signOut() async {
  try {
    await _auth.signOut();
    print("User signed out");
    // Navigate to the login screen or any other screen after logout
    // Example: Navigator.pushReplacementNamed(context, '/login');
  } catch (e) {
    print("Error signing out: $e");
  }
}
  
//   void route() {
//     User? user = FirebaseAuth.instance.currentUser;
//     var kk = FirebaseFirestore.instance
//             .collection('users')
//             .doc(user!.uid)
//             .get()
//             .then((DocumentSnapshot documentSnapshot) {
//       if (documentSnapshot.exists) {
//         if (documentSnapshot.get('role') == "user") {
//          Navigator.of(context as BuildContext).push(MaterialPageRoute(
//           builder: (c) {
//             return const UserHome();
//           },
//         ));
//         }else{
//           Navigator.of(context as BuildContext).push(MaterialPageRoute(
//           builder: (c) {
//             return const UserHome();
//           },
//           ));
//         }
//       }
//       });
//   }
//  void signIn(String email, String password) async {
//     if (_formkey.currentState!.validate()) {
//       try {
//         UserCredential userCredential =
//             await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: email,
//           password: password,
//         );
//         route();
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'user-not-found') {
//           print('No user found for that email.');
//         } else if (e.code == 'wrong-password') {
//           print('Wrong password provided for that user.');
//         }
//       }
//     }
//    }

