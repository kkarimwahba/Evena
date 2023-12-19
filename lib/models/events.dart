class Event {
  String title;
  String description;
  DateTime date;
  String time;
  String location;
  String category;
  double price;
  String image;
  int availability;

  Event({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.category,
    required this.price,
    required this.image,
    required this.availability,
  });
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date.toIso8601String(), // Convert DateTime to ISO format
      'time': time,
      'location': location,
      'category': category,
      'price': price,
      'image': image,
      'availability': availability,
    };
  }
}
