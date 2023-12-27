import 'package:flutter/material.dart';
import 'ticket.dart';

class UserProvider extends ChangeNotifier {
  String uid = '';
  String username = '';
  String email = '';
  String password = '';
  String phone = '';
  String? role;
  List<Ticket>? tickets;

  void setUser({
    required String uid,
    required String username,
    required String email,
    required String password,
    required String phone,
    String? role,
    List<Ticket>? tickets,
  }) {
    this.uid = uid;
    this.username = username;
    this.email = email;
    this.password = password;
    this.phone = phone;
    this.role = role;
    this.tickets = tickets;

    notifyListeners();
  }
}
