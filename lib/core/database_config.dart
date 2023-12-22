// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:with_todo/core/common/model/todo.dart';
// import 'package:with_todo/features/todo/model/check_list_model.dart';

// class DatabaseService {
//   static final DatabaseService _database = DatabaseService._internal();
//   late Future<Database> database;

//   factory DatabaseService() => _database;

//   DatabaseService._internal() {
//     databaseConfig();
//   }

//   Future<bool> databaseConfig() async {
//     //데이터베이스 생성
//     try {
//       database = openDatabase(
//         join(await getDatabasesPath(), 'todo_database.db'),
//         onCreate: (db, version) {
//           return db.execute(
//             'CREATE TABLE todos(id INTEGER PRIMARY KEY, desc TEXT)',
//           );
//         },
//         version: 1,
//       );
//       return true;
//     } catch (e) {
//       print(e.toString());
//       return false;
//     }
//   }

//   Future<bool> insertTodo(CheckListModel todo) async {
//     //데이터 삽입
//     final Database db = await database;
//     try {
//       db.insert(
//         'todos',
//         todo.toMap(),
//         conflictAlgorithm:
//             ConflictAlgorithm.replace, //동일한 레코드를 두 번 삽입하려고 할 때 따라야하는 동작을 지정
//       );
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<List<CheckListModel>> selectTodos() async {
//     //할일 목록 리스트
//     final Database db = await database;
//     final List<Map<String, dynamic>> data = await db.query('todos');

//     return List.generate(data.length, (i) {
//       return CheckListModel(
//         id: data[i]['id'],
//         checkable: data[i]['checkable'],
//         content: data[i]['content'],
//         state: data[i]['state'],
//       );
//     });
//   }

//   Future<CheckListModel> selectTodo(int id) async {
//     //할일 목록 하나만 가져오기
//     final Database db = await database;
//     final List<Map<String, dynamic>> data =
//         await db.query('todo', where: 'id = ?', whereArgs: [id]);
//     return CheckListModel(
//       id: data[0]['id'],
//       checkable: data[0]['checkable'],
//       content: data[0]['content'],
//       state: data[0]['state'],
//     );
//   }

//   Future<bool> updateTodo(CheckListModel todo) async {
//     //데이터 수정
//     final Database db = await database;
//     try {
//       db.update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<bool> deleteTodo(int id) async {
//     //데이터 삭제
//     final Database db = await database;
//     try {
//       db.delete('todos', where: 'id = ?', whereArgs: [id]);
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
// }
//위에꺼 보류

import 'dart:math';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:with_todo/features/todo/model/check_list_model.dart';

class SQLiteHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      //이미 초기화된 경우 기존 데이터베이스 인스턴스 반환
      return _database!;
    }
    _database = await initWinDB(); //아직 초기화 되지 않은 경우 초기화
    return _database!;
  }

  Future<Database> initWinDB() async {
    sqfliteFfiInit();
    final databaseFactory = databaseFactoryFfi;
    return await databaseFactory.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        onCreate: _onCreate,
        version: 1,
      ),
    );
  }

  Future<void> _onCreate(Database database, int version) async {
    final db = database;
    await db.execute(""" CREATE TABLE IF NOT EXISTS users(
      id INTEGER PRIMARY KEY,
      checkable BOOLEAN,
      content TEXT,
      state TEXT,
    )
    """);
  }

  Future<List<CheckListModel>> getAllCheckList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('checklist');

    return List.generate(maps.length, (index) {
      return CheckListModel(
        id: maps[index]['id'],
        checkable: maps[index]['checkable'],
        content: maps[index]['content'],
        state: maps[index]['state'],
      );
    });
  }

  Future<void> insertCheckItem(CheckListModel checklist) async {
    final db = await database;
    db.insert(
      "checklist",
      checklist.toMap(),
    );
  }

  Future<void> updateCheckItem(CheckListModel checklist) async {
    final db = await database;
    db.update(
      'checklist',
      checklist.toMap(),
      where: 'id = ?',
      whereArgs: [checklist.id],
    );
  }

  Future<void> deleteCheckItem(int id) async {
    final db = await database;
    db.delete(
      'checklist',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
