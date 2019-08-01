import 'package:fetchdata/Vivo.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'IssData.dart';
import 'Jsonfetcher.dart';

class PantallaMapa extends StatefulWidget {
  PantallaMapa({Key key}) : super(key: key);

  _PantallaMapaState createState() => _PantallaMapaState();
}

class _PantallaMapaState extends State<PantallaMapa> {
  GoogleMapController mapController;
  Future<IssData> geolocalizacion;
  Set<Marker> markers = {};
  @override
  void initState() {
    super.initState();
    obtenerData();
  }

  obtenerData() async {
    geolocalizacion = obtenerDesdeApi();
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
                      zoom: 3,
                      target: LatLng(
                          snapshot.data.latitude, snapshot.data.longitude),
                    ),
                  ),
                ),
                Text('${snapshot.data.latitude}'),
                Text('${snapshot.data.longitude}'),
                RaisedButton(
                  child: Center(
                    child: Text('Refesh'),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PantallaMapa();
                        },
                      ),
                    );
                  },
                ),
                RaisedButton(
                    child: Text('VivoNow'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return VideoEnVivo();
                          },
                        ),
                      );
                    }),
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
