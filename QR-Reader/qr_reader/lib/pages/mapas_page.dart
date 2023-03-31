import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/scan_tiles.dart';


class MapasPage extends StatelessWidget {
  const MapasPage({super.key});


  @override
  Widget build(BuildContext context) {
return const ScanTiles(tipo: 'geo');
//*tambien se podria colocar en el home page dentro de los case del switch
  }
}