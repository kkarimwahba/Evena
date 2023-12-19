class BookingModel {
  String name;
  String phoneNumber;
  String email;

  BookingModel({
    required this.name,
    required this.phoneNumber,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }
}
