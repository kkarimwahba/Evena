import 'ticket.dart';

class User {
  String name;
  String email;
  String password;
  String phone;
  List<Ticket> tickets;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.tickets,
  });
}
