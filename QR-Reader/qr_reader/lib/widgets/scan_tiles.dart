import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  final String tipo;
  const ScanTiles({super.key, required this.tipo});

  @override
  Widget build(BuildContext context) {
        //*por lo general si estamos dentro de un build el listen se deja en true
    //*Dentro de un método por lo general el listen va en false
      final scanListProvider= Provider.of<ScanListProvider>(context);
    final scans= scanListProvider.scans;
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i)=>Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(context,listen: false).borrarScanById(scans[i].id!);
        },
        child: ListTile(
          leading: Icon(
            tipo== 'http'
            ?Icons.map_outlined
            :Icons.home,
            color: Theme.of(context).primaryColor, ),
            title:  Text(scans[i].valor),
            subtitle:  Text(scans[i].id.toString()),
            trailing: const Icon(Icons.home, color: Colors.grey,),
            onTap: () => launchInBrowser(context, scans[i]),
        ),
      )
      );
  }
}