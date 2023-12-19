import 'package:firebase_auth/firebase_auth.dart';

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

Future<User?> registerWithEmailAndPassword(
    String email, String password) async {
  try {
    UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = result.user;
    return user;
  } catch (error) {
    print('Error signing in:$error');
    return null;
    }
}


