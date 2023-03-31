import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

import '../utils/utils.dart';
class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: ()async {
       //String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('3D8BEF', 'Cancelar', false,ScanMode.QR);
     //   final barcodeScanRes= 'https://google.com';
        final barcodeScanRes=  '-36.922587, -60.314599';
        final scanListProvider= Provider.of<ScanListProvider>(context, listen:false);
       final nuevoScan= await scanListProvider.nuevoScan(barcodeScanRes);
             
      launchInBrowser(context, nuevoScan);
      
         },
      child: const Icon(Icons.filter_center_focus),

    );
  }
}