import 'dart:convert';
import 'package:evena/models/users.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class SendEmail {
  String name;
  String subject;
  String message;

  SendEmail({
    required this.name,
    required this.subject,
    required this.message,
  });

  Future<void> sendReminderEmail() async {
    final serviceId = 'service_13mv458';
    final templateId = 'template_jz85apg';
    final userId = '';

    final Uri url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    // Get the user's email from Firebase
    String userEmail = await getUserEmail();

    // Check if the event is tomorrow
    DateTime eventDate =
        DateTime(2024, 1, 6); // Replace with the actual event date
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));

    if (eventDate.year == tomorrow.year &&
        eventDate.month == tomorrow.month &&
        eventDate.day == tomorrow.day) {
      String formattedDate =
          '${eventDate.year}-${eventDate.month}-${eventDate.day}';

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'to_email': userEmail,
            'subject': subject,
            'message': '$message\nEvent is tomorrow on $formattedDate',
          },
        }),
      );

      print(response.body);
    } else {
      print('Event is not tomorrow.');
    }
  }

  Future<String> getUserEmail() async {
    // Query Firebase for the user's email
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('uid',
            isEqualTo: user!.uid) // Assuming user is accessible in this context
        .limit(1)
        .get();

    // Extract the email from the query result
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first[
          'email']; // Replace 'email' with the actual field in your document
    } else {
      throw Exception('User not found or email field is missing.');
    }
  }
}
