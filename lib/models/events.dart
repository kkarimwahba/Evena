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
    required imagePath,
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

  // Factory constructor to create an Event object from Firebase data
  factory Event.fromFirebase(Map<String, dynamic> data) {
    return Event(
      title: data['title'],
      description: data['description'],
      date: DateTime.parse(data['date']),
      time: data['time'],
      location: data['location'],
      category: data['category'],
      price: data['price'].toDouble(),
      image: data['image'],
      availability: data['availability'],
      imagePath: null,
    );
  }

  // Factory constructor to create an Event object from SQLite data
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      title: map['title'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      time: map['time'],
      location: map['location'],
      category: map['category'],
      price: map['price'].toDouble(),
      image: map['image'],
      availability: map['availability'],
      imagePath: null,
    );
  }
}
