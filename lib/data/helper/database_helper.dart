import 'package:restaurant_app_api/data/model/bookmark_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('restaurant_bookmarks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE bookmarks (
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT,
      pictureId TEXT,
      city TEXT,
      rating REAL
    )
    ''');
  }

  Future<void> insertBookmark(BookmarkModel bookmark) async {
    final db = await instance.database;
    await db.insert('bookmarks', bookmark.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeBookmark(String id) async {
    final db = await instance.database;
    await db.delete('bookmarks', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<BookmarkModel>> getBookmarks() async {
    final db = await instance.database;
    final result = await db.query('bookmarks');
    return result.map((map) => BookmarkModel.fromMap(map)).toList();
  }
}
