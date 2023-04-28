import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_reader/models/scan_model.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  //*completer sera un future el cual va a contener el google maps controller
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
      MapType mapType= MapType.normal;
  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition puntoInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 50, //*grado de inclinación en la vista del mapa
    );
    //*marcadores
    Set<Marker> markers = Set<Marker>();
    markers.add(
        Marker(markerId: const MarkerId('geo-location'), position: scan.getLatLng()));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        actions: [
          IconButton(//*boton para volver al marcador 
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: scan.getLatLng(), zoom: 17, tilt: 50)));
              },
              icon: const Icon(Icons.location_on))
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled:
            false, //*deshabilitar el boton de mi posición actual
        mapType: mapType,
        markers: markers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      //* cambiar tipo de mapa
      floatingActionButton: FloatingActionButton(onPressed: () {
        if (mapType==MapType.normal){
          mapType=MapType.satellite;
        }else{
          mapType=MapType.normal;
        }
        setState(() {});
       },
       child: const Icon(Icons.layers),),
    );
  }
}
