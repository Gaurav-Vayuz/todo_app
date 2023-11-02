import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHandler {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        date TEXT
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'todo_list',
      version: 1,
      onCreate: (db, version) async {
        await createTable(db);
      },
    );
  }

  static Future<int> createItem(String title, String desc, String date) async {
    final db = await DatabaseHandler.db();
    final data = {'title': title, 'description': desc, 'date': date};
    final result = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return result;
  }

  Future<List<Map<String, dynamic>>> retrieveTodos() async {
    final db = await DatabaseHandler.db();
    return db.query('items', orderBy: "id");
  }

  Future<int> editTodo(int id, String title, String desc, String date) async {
    final db = await DatabaseHandler.db();
    final data = {'title': title, 'description': desc, 'date': date};

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<void> deleteTodo(int id) async {
    final db = await DatabaseHandler.db();
    await db.delete(
      'items',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
