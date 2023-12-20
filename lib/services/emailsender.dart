// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';
// import 'package:flutter/material.dart';

// final email='khaled2002775@miuegypt.edu.eg';

// User? user = FirebaseAuth.instance.currentUser;
// String? useremail =user?.email;

// Future sendEmail(String ) async{

// final smtpServer= gmailSaslXoauth2(useremail, accessToken)

//   final message = Message()
//     ..from = Address(email, 'khaled')
//     ..recipients.add('$useremail')
//     ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
//     ..bccRecipients.add(Address('bccAddress@example.com'))
//     ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
//     ..text = 'This is the plain text.\nThis is line 2 of the text part.'
//     ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

//   try {
//     final sendReport = await send(message, smtpServer);
//     print('Message sent: ' + sendReport.toString());
//   } on MailerException catch (e) {
//     print('Message not sent.');
//     for (var p in e.problems) {
//       print('Problem: ${p.code}: ${p.msg}');
//     }
// }
// }