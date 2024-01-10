import 'package:evena/models/events.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  late Database _database;

  Future<void> initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'events_database.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('CREATE TABLE events ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'title TEXT, '
            'description TEXT, '
            'date TEXT, '
            'time TEXT, '
            'location TEXT, '
            'category TEXT, '
            'price TEXT, '
            'availability TEXT, '
            'imagePath TEXT)');
      },
    );
  }

  Future<void> insertEvent(Event event) async {
    await _database.insert('events', event.toJson());
  }

  Future<List<Event>> getEvents() async {
    final List<Map<String, dynamic>> maps = await _database.query('events');
    return List.generate(maps.length, (i) {
      return Event(
        title: maps[i]['title'],
        description: maps[i]['description'],
        date: DateTime.parse(maps[i]['date']),
        time: maps[i]['time'],
        location: maps[i]['location'],
        category: maps[i]['category'],
        price: maps[i]['price'],
        availability: maps[i]['availability'],
        imagePath: ' maps[i][' ']',
        image: '',
      );
    });
  }
}
