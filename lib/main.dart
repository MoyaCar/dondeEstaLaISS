import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IssData {
  final double latitude;
  final double longitude;

  IssData({this.latitude, this.longitude});
  factory IssData.fromApi(Map<String, dynamic> json) {
    return IssData(latitude: json['latitude'], longitude: json['longitude']);
  }
}

Future<IssData> obtenerDesdeApi() async {
  final response =
      await http.get('https://api.wheretheiss.at/v1/satellites/25544');
  if (response.statusCode == 200) {
    return IssData.fromApi(json.decode(response.body));
  } else {
    throw Exception('Sin Inet o Datos');
  }
}

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

  _PantallaPrincipalState createState() =>
      _PantallaPrincipalState(geolocalizacion: obtenerDesdeApi());
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  GoogleMapController mapController;
  final Future<IssData> geolocalizacion;

  _PantallaPrincipalState({this.geolocalizacion});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: geolocalizacion,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: GoogleMap(
                onMapCreated: onmap,
                initialCameraPosition: CameraPosition(
                  target:
                      LatLng(snapshot.data.latitude, snapshot.data.longitude),
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  void onmap(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}
