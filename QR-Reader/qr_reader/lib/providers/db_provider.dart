import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db= DBProvider._();


DBProvider._();

  Future<Database> get database async => _database ??= await initDB();
 
  Future<Database> initDB() async { Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
 CREATE TABLE Scans(
 id INTEGER PRIMARY KEY,
 tipo TEXT,
 valor TEXT
 )
 
 ''');
      },
    );
  }
  //*Raw insert
Future<int> nuevoScanRaw( ScanModel nuevoScan)async {
final id = nuevoScan.id;
final tipo = nuevoScan.tipo;    
final valor = nuevoScan.valor;        
final db= await database;
final res = await db.rawInsert('''
INSERT INTO Scans(id, tipo, valor)
VALUES($id, '$tipo', '$valor')
''');
return res;
  }
 Future<int> nuevoScan(ScanModel nuevoScan)async{
    final db= await database;
    final res= await db.insert('Scans', nuevoScan.toJson() );
    return res;
  }
//*obtener registros

Future <ScanModel?> getScanById(int id) async{
  final db= await database;
  final res= await db.query('Scans', where: 'id= ?', whereArgs:[id]);

  return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
}
Future <List<ScanModel>?> getAllScans() async{
  final db= await database;
  final res= await db.query('Scans');

  return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() 
  : [];

  }
  Future <List<ScanModel>?> getScansByTipo(String tipo) async{
  final db= await database;
  final res= await db.rawQuery('''
SELECT * FROM Scans WHERE tipo='$tipo'
''');

  return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() 
  : [];

  }

  //* actualizar registros
Future<int> updateScan(ScanModel nuevoScan)async{
  final db= await database;
  final res= await db.update('Scans', nuevoScan.toJson(), where: 'id=?',whereArgs: [nuevoScan.id]);
  return res;

}
//*borrar registros  independientes (slide-to-delete)
Future <int> deleteScan(int id)async{
  final db= await database;
  final res= await db.delete('Scans', where: 'id=?', whereArgs: [id]);
  return res;
}
//*borrar todos los registros raw query
Future <int> deleteAllScans()async{
  final db= await database;
  final res= await db.rawDelete(''' 
  DELETE FROM Scans
  ''');
  return res;
}
}
