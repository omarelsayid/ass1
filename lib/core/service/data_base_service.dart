import 'dart:developer';
import 'dart:io';
import 'package:ass1/data/models/feed_back_model.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

@injectable
@LazySingleton() // or @Singleton()
class DataBaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'feedback_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE feedbacks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT NOT NULL,
        email TEXT NOT NULL,
        feedBackMessage TEXT NOT NULL,
        rating TEXT NOT NULL
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    log('Database upgraded from version $oldVersion to $newVersion');
  }

  Future<int> insertFeedback(FeedBackModel feedback) async {
    final db = await database;
    return await db.insert(
      'feedbacks',
      feedback.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<FeedBackModel>> getFeedbacks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('feedbacks');
    return maps.map((map) => FeedBackModel.fromMap(map)).toList();
  }
}
