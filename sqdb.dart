import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDB{
  static Database? _db;
  Future<Database?> get db async {
    return _db ?? await initDb();
  }

  initDb() async {
    String DBPath = await getDatabasesPath();
    String path = join(DBPath, 'todo.db');
    _db = await openDatabase(path, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return _db;
  }

  _onCreate(Database db, int version) async{
    await db.execute('''
    CREATE TABLE tasks(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      task TEXT NOT NULL,
      is_done INTEGER DEFAULT 0,
      category TEXT NOT NULL
      )
    ''');
    print ("Table created!");
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await _onCreate(db, newVersion);
    if (newVersion > oldVersion) {
      await db.execute('ALTER TABLE tasks ADD COLUMN category TEXT');
      print("Table updated!");
    }
  }
  Future<List<Map>> readData(String category) async {
    Database? db = await this.db;
    List<Map> response = await db!.query('tasks', where: 'category = ?', whereArgs: [category]);
    print("Data read!");
    return response;
  }

  Future<int> insertData(String task, String category) async {
    Database? db = await this.db;
    int response = await db!.insert('tasks', {'task': task, 'is_done': 0, 'category': category});
    print("Data inserted!");
    return response;

  }

  Future<int> deleteData(int id) async {
    Database? db = await this.db;
    int response = await db!.delete('tasks', where: 'id = ?', whereArgs: [id]);
    print("Data deleted!");
    return response;
  }

  Future<int> updateData(String task, int id) async {
    Database? db = await this.db;
    int response = await db!.update('tasks', {'task': task}, where: 'id = ?', whereArgs: [id]);
    print("Data updated!");
    return response;
  }
  Future<int> removeAll(String category) async {
    Database? db = await this.db;
    int response = await db!.delete('tasks', where: 'category = ?', whereArgs: [category]);
    print("All data deleted!");
    return response;
  }

  Future <int> updateStatus (int id, int isDone) async {
    Database? db = await this.db;
    int response = await db!.update('tasks', {'is_done': isDone}, where: 'id = ?', whereArgs: [id]);
    print("Status updated!");
    return response;
  }



  }

