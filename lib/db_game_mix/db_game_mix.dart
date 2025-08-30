import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import './game_mix_entity.dart';

class DB extends GetxService {
  Database? _database;

  Future<DB> init() async {
    await dbBase;
    return this;
  }

  Future<Database> get dbBase async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'game_mix.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE grid_game (
          sort_order INTEGER NOT NULL,
          type TEXT NOT NULL,
          value TEXT NOT NULL
        )
        ''');
        await db.execute('''
        CREATE TABLE draw_lots (
          result TEXT NOT NULL,
          probability REAL NOT NULL,
          created_at TEXT NOT NULL
        )
        ''');
      },
    );
  }

  Future<int> insertGridGame(GridGameEntity gridGame) async {
    final db = await dbBase;
    return await db.insert('grid_game', gridGame.toMap());
  }

  Future<int> updateGridGame(GridGameEntity gridGame) async {
    final db = await dbBase;
    return await db.update(
      'grid_game',
      gridGame.toMap(),
      where: 'sort_order = ?',
      whereArgs: [gridGame.order],
    );
  }

  Future<List<GridGameEntity>> getAllGridGames() async {
    final db = await dbBase;
    final List<Map<String, dynamic>> maps = await db.query('grid_game');

    return List.generate(maps.length, (i) {
      return GridGameEntity.fromMap(maps[i]);
    });
  }

  Future<int> insertDrawLots(DrawLotsEntity drawLots) async {
    final db = await dbBase;
    return await db.insert('draw_lots', drawLots.toMap());
  }

  Future<List<DrawLotsEntity>> getAllDrawLots() async {
    final db = await dbBase;
    final List<Map<String, dynamic>> maps = await db.query(
      'draw_lots',
      orderBy: 'created_at DESC',
    );

    return List.generate(maps.length, (i) {
      return DrawLotsEntity.fromMap(maps[i]);
    });
  }

  Future<DrawLotsEntity?> getDrawLotsByDate(DateTime today) async {
    final db = await dbBase;

    final dateString =
        '${today.year.toString().padLeft(4, '0')}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    final List<Map<String, dynamic>> maps = await db.query(
      'draw_lots',
      where: 'created_at LIKE ?',
      whereArgs: ['$dateString%'],
      orderBy: 'created_at DESC',
    );

    if (maps.isEmpty) {
      return null;
    }

    return DrawLotsEntity.fromMap(maps[0]);
  }

  Future<void> deleteDrawLots(String result, String createdAt) async {
    final db = await dbBase;
    await db.delete(
      'draw_lots',
      where: 'result = ? AND created_at = ?',
      whereArgs: [result, createdAt],
    );
  }

  Future<void> deleteAllDrawLots() async {
    final db = await dbBase;
    await db.delete('draw_lots');
  }

  Future<void> clearRecords() async {
    final db = await dbBase;
    try {
      await db.delete('grid_game');
      await db.delete('draw_lots');
    } catch (e) {
      print('Clear data error: $e');
    }
  }

  @override
  void onClose() {
    _database?.close();
    super.onClose();
  }
}
