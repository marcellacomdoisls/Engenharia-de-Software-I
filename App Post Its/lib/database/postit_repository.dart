import 'package:path/path.dart';
import 'package:postit_app/database/postit.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class PostitRepository {
  static final PostitRepository instance = PostitRepository();

  Database? _database;
  final List<void Function()> listenerCallbacks = [];

  Future<void> init() async {
    _database = await databaseFactoryFfi.openDatabase(
      join(await databaseFactoryFfi.getDatabasesPath(), 'postit_database.db'),
      options: OpenDatabaseOptions(
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE postits(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, date TEXT)",
          );
        },
        version: 1,
      ),
    );
    print(_database);
  }

  Future<void> add(Postit postit) async {
    if (_database != null) {
      await _database!.insert(
        'postits',
        postit.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      update();
    }
  }

  Future<List<Postit>> getAll() async {
    if (_database != null) {
      final List<Map<String, dynamic>> maps = await _database!.query('postits');
      return List.generate(maps.length, (i) {
        return Postit(
          id: maps[i]['id'],
          title: maps[i]['title'],
          description: maps[i]['description'],
          date: maps[i]['date'],
        );
      });
    }
    return [];
  }

  void addListener(void Function() callback) {
    listenerCallbacks.add(callback);
  }

  void removeListener(void Function() callback) {
    listenerCallbacks.remove(callback);
  }

  void update() {
    for (var callback in listenerCallbacks) {
      callback();
    }
  }
}
