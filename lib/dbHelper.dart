import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyPokes{
  final int id;

  MyPokes({required this.id});

  factory MyPokes.fromMap(Map<String, dynamic> map){
    return MyPokes(id: map['id']);
  }

  Map<String, dynamic> toMap(){
    return{'id':id};
  }

}
const tableName = 'pokemons';
class dbHelper{
  dbHelper._();
  static final dbHelper db = dbHelper._();
  static Database? _datab;
  Future<Database> get datab async => _datab ?? await _start();

  Future<Database> _start() async{
    return openDatabase(
        join(await getDatabasesPath(), 'doggie_database.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE $tableName(id INTEGER PRIMARY KEY)',
        );
    },

    version: 1,
    );
  }

  Future<List<MyPokes>> getAllPokes() async{
    final db = await datab;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (index) => MyPokes.fromMap(maps[index]));
  }

  Future<void> insertPoke(MyPokes poke) async{
    final db = await datab;
    await db.insert(tableName, poke.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deletePoke(MyPokes poke) async{
    final db = await datab;
    await db.delete(tableName, where: 'id = ?', whereArgs: [poke.id]);
  }


}