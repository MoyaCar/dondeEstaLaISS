import 'Jsonfetcher.dart';
import 'IssData.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatefulWidget {
  PantallaPrincipal({Key key}) : super(key: key);

  _PantallaPrincipalState createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  GoogleMapController mapController;
  Future<IssData> geolocalizacion;

  Set<Marker> markers = {};
  @override
  void initState() {
    super.initState();
    obtenerData();
  }

  obtenerData() async {
    setState(() {
      geolocalizacion = obtenerDesdeApi();
    });

    await Future.delayed(Duration(milliseconds: 4000));
    obtenerData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: geolocalizacion,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            addmark(
              LatLng(snapshot.data.latitude, snapshot.data.longitude),
            );

            return Center(
                child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 300,
                  child: GoogleMap(
                    markers: markers,
                    onMapCreated: onmap,
                    initialCameraPosition: CameraPosition(
                      zoom: 5,
                      target: LatLng(
                          snapshot.data.latitude, snapshot.data.longitude),
                    ),
                  ),
                ),
                Text('${snapshot.data.latitude}'),
                Text('${snapshot.data.longitude}'),
              ],
            ));
          }
          if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void addmark(LatLng latLng) {
    markers.add(
      Marker(
        markerId: MarkerId('Iss'),
        position: latLng,
        infoWindow: InfoWindow(title: 'Iss', snippet: 'Ubicación actual'),
      ),
    );
  }

  void onmap(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}
