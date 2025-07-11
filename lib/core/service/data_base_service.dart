import 'dart:developer';
import 'dart:io';
import 'package:ass1/data/models/feed_back_model.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

@injectable
class DataBaseService {
  static final DataBaseService instance = DataBaseService._privateConstructor();
  static Database? _database;

  DataBaseService._privateConstructor();
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

  // Creates the 'feedbacks' table when the database is first created
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

  // Optional: Handles database upgrades (e.g., adding new columns, tables)
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // This is where you would handle schema changes if your database version increases.
    // For example:
    // if (oldVersion < 2) {
    //   await db.execute("ALTER TABLE feedbacks ADD COLUMN new_column TEXT;");
    // }
    log('Database upgraded from version $oldVersion to $newVersion');
  }

  Future<int> insertFeedback(FeedBackModel feedback) async {
    Database db = await instance.database;
    return await db.insert(
      'feedbacks',
      feedback.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all feedback entries from the database
  Future<List<FeedBackModel>> getFeedbacks() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('feedbacks');

    return List.generate(maps.length, (i) {
      return FeedBackModel.fromMap(maps[i]);
    });
  }
}
