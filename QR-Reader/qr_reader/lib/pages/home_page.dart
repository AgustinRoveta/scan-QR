import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/direcciones_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/custom_navigation_bar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Historial'),
        actions: [
          IconButton(
              onPressed: () async {
                final scanListProvider =
                    Provider.of<ScanListProvider>(context, listen: false);
                scanListProvider.borrarTodos();
              },
              icon: const Icon(Icons.delete_outline))
        ],
      ),
      body: const _HomePageBody(),
      // bottomNavigationBar
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    //obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);
    //cambiar para mostrar la pagina respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    //todo: temporal leer base de datos
    //final tempScan= ScanModel(valor: 'http://google.com');
    //prueba nuevoScanDBProvider.db.nuevoScan(tempScan);
    //prueba getScanById DBProvider.db.getScanById(16).then((scan) => print(scan!.valor));
    //prueba getAllScans DBProvider.db.getAllScans().then(print);
    //prueba deleteAllScans DBProvider.db.deleteAllScans().then(print);
    //*usar ScanListProvider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansByTipo('geo');
        return const MapasPage();
      case 1:
        scanListProvider.cargarScansByTipo('http');
        return const DireccionesPage();
      default:
        return const MapasPage();
    }
  }
}
