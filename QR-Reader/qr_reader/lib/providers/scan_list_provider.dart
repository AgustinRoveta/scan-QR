import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';
//*servicio centralizado, lugar donde vamos a buscar la informacion relacionada 
//*a los scans, actualizando la interfaz de usuario

class ScanListProvider extends ChangeNotifier {

List <ScanModel> scans =[];
String tipoSeleccionado= 'http';
  //*metodo para crear nuevo scan
 Future<ScanModel> nuevoScan(String valor)async{
//*insercion en base de datos
   final nuevoScan= ScanModel(valor: valor);
   final id= await DBProvider.db.nuevoScan(nuevoScan);
   //*asignacion del id de la base de datos al modelo
   nuevoScan.id=id;
//*insercion del nuevo scan al listado de scans con condicional en base al
//* tipo para que se muestre o no en la interfaz de usuario
//* es decir que solo lo insertara  si son del mismo tipo
if (tipoSeleccionado==nuevoScan.tipo){
   scans.add(nuevoScan);
   notifyListeners();
}
return nuevoScan;
  }

  cargarScans() async{
    final scans = await DBProvider.db.getAllScans();
  this.scans=[...?scans];
  notifyListeners();
  }
   
  cargarScansByTipo(String tipo)async{
     final scans = await DBProvider.db.getScansByTipo(tipo);
  this.scans=[...?scans];
  tipoSeleccionado=tipo;
  notifyListeners();
  }
  borrarTodos()async{
await DBProvider.db.deleteAllScans();
scans=[];
notifyListeners();
  }
    borrarScanById(int id)async{
await DBProvider.db.deleteScan(id);
cargarScansByTipo(tipoSeleccionado);
//*no va notifyListeners porque ya esta dentro del metodo cargarScansByTipo
  }
}