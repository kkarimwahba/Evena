import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evena/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

Future<User?> signinwithemailandpassword(String email, String password) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print(credential.user?.uid);
    return credential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

Future<User?> registerWithEmailAndPassword(String email, String password,String username,String phone,) async {
  try {
    // Create user in Firebase Authentication
    UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    User? user = result.user;

    // Generate a unique Firestore document ID for the user
    String firestoreUserId = FirebaseFirestore.instance.collection('users').doc().id;

    // Create a Firestore document for the user using the generated ID
    await FirebaseFirestore.instance.collection('users').doc(firestoreUserId).set({
       'uid':user?.uid,
        "name":username,
        "email":email,
        "password":password,
        "phone":phone,
        "role":'user',
       // Store user's email
      // Add other user-related fields if needed
    });

    return user;
  } catch (error) {
    print('Error registering user: $error');
    return null;
  }
}


