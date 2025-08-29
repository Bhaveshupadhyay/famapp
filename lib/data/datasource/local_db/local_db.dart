import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../models/saved_card.dart';

class LocalDb {
  static final LocalDb instance = LocalDb._init();
  static Database? _db;

  LocalDb._init();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB('saved_cards.db');
    return _db!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE saved_cards(
        card_id INTEGER PRIMARY KEY,
        is_dismiss INTEGER NOT NULL,
        is_remind INTEGER NOT NULL,
        is_showed INTEGER NOT NULL,
        payload TEXT
      )
    ''');
  }

  Future<SavedCard?> getCard(int cardId) async {
    final db = await database;
    final maps = await db.query(
      'saved_cards',
      where: 'card_id = ?',
      whereArgs: [cardId],
      limit: 1,
    );
    if (maps.isNotEmpty) return SavedCard.fromMap(maps.first);
    return null;
  }

  Future<void> upsertCard(SavedCard card) async {
    final db = await database;
    await db.insert(
      'saved_cards',
      card.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SavedCard>> getAllCards() async {
    final db = await database;
    final rows = await db.query('saved_cards');
    return rows.map((r) => SavedCard.fromMap(r)).toList();
  }

  Future<int> deleteCard(String cardId) async {
    final db = await database;
    return await db.delete('saved_cards', where: 'card_id = ?', whereArgs: [cardId]);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _db = null;
  }
}
