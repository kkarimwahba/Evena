import 'ticket.dart';


class UserBase {
  String uid;
  String username;
  String email;
  String password;
  String phone;
  List<Ticket>? tickets;

  UserBase({
    required this.uid,
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
    this.tickets,
    });


    tojson()
    {
      return{
        "name":username,
        "email":email,
        "password":password,
        "phone":phone,
        
      };
    }
}

