import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sqldb {
  initiaDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'ali.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 3, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE STUDENT (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  name TEXT NOT NULL,
  dep_name TEXT NOT NULL,
  coll_name TEXT NOT NULL,
  level INTEGER NOT NULL
) ''');
    await db.execute(
        '''CREATE TABLE subjects(sub_id INTEGER PRIMARY KEY AUTOINCREMENT, colSubjectName TEXT, dep_name TEXT,coll_name TEXT,sub_level INTEGER  )
''');
    await db.execute(
        '''CREATE TABLE Attendance(std_id INTEGER ,sub_id INTEGER,is_present BOOLEAN  )
''');
    print("create stuent table ");
  }

  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initiaDb();
      return (_db);
    } else {
      return (_db);
    }
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion)  {

  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deletdata(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  mydeleteDatabase() async {
    String databasepath =
        await getDatabasesPath(); //define defalut location to store database
    String path = join(databasepath, 'ali.db');
    await deleteDatabase(path);
  }
}
