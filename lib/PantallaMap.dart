import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:fetchdata/MixinsViewModes.dart';
import 'package:fetchdata/Vivo.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'PopUp.dart';
import 'MixinsViewModes.dart';
import 'PantallaHome.dart';

import 'IssData.dart';
import 'Jsonfetcher.dart';
import 'PopUpRoute.dart';

class PantallaMapa extends StatefulWidget {
  PantallaMapa({Key key}) : super(key: key);

  _PantallaMapaState createState() => _PantallaMapaState();
}

Color colorFuente = Colors.white.withOpacity(0.8);
Color colorFondo = Color(0xff1C1818);
Color colorsecundario = Color(0xff6076E9);

class _PantallaMapaState extends State<PantallaMapa>
    with PortraitModeOnly<PantallaMapa>, TickerProviderStateMixin {
  GoogleMapController mapController;
  Future<IssData> geolocalizacion;
  Set<Marker> markers = {};
  AnimationController controladorDeForma,
      controladorDePosicion,
      controladorDeAparicion,
      controladorDeDesaparicion;
  Animation animacionDeForma,
      animaCionDeAparicion,
      animacionDePosicionY,
      animacionDesaparicion;
  Duration duaracion;
  bool estaIniciado = false;

  @override
  void initState() {
    super.initState();
    obtenerData();

    controladorDeDesaparicion =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));

    animacionDesaparicion =
        Tween<double>(begin: 0, end: 1).animate(controladorDeDesaparicion)
          ..addListener(() {
            setState(() {});
          });

    BackButtonInterceptor.add(myInterceptor);
    duaracion = Duration(milliseconds: 250);

    controladorDeForma = AnimationController(vsync: this, duration: duaracion);
    controladorDePosicion =
        AnimationController(vsync: this, duration: duaracion);
    controladorDeAparicion =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    animaCionDeAparicion =
        Tween<Offset>(begin: Offset(340, 640), end: Offset(150, 450))
            .animate(controladorDeAparicion)
              ..addListener(() {
                setState(() {});
              });

    animacionDeForma = BorderRadiusTween(
            begin: BorderRadius.circular(300), end: BorderRadius.circular(10))
        .animate(controladorDeForma)
          ..addListener(() {
            setState(() {});
          });

    animacionDePosicionY =
        Tween<Offset>(begin: Offset(150, 450), end: Offset(0, 0))
            .animate(controladorDePosicion)
              ..addListener(
                () {
                  setState(() {});
                },
              );
    animacionDeInicio();
  }

  animacionDeInicio() async {
    controladorDeAparicion.forward();
    await Future.delayed(Duration(seconds: 1));
    controladorDeDesaparicion.forward();
    estaIniciado = true;
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    print("BACK BUTTON!"); // Do some stuff.
    return true;
  }

  obtenerData() async {
    geolocalizacion = obtenerDesdeApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorsecundario,
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              FutureBuilder(
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
                            height: 500,
                            child: GoogleMap(
                              markers: markers,
                              onMapCreated: onmap,
                              initialCameraPosition: CameraPosition(
                                zoom: 3,
                                target: LatLng(snapshot.data.latitude,
                                    snapshot.data.longitude),
                              ),
                            ),
                          ),
                          BotonRefrescar(),
                          BotonVerEnVivo(),
                        ],
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error);
                  }
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 300),
                    child: CircularProgressIndicator(),
                  ));
                },
              ),
            ],
          ),
          Transform.translate(
            offset: estaIniciado
                ? animacionDePosicionY.value
                : animaCionDeAparicion.value,
            child: GestureDetector(
              onTap: () async {
                controladorDeForma.forward();
                controladorDePosicion.forward();
                await Future.delayed(duaracion);
                await Future.delayed(Duration(milliseconds: 50));

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MainHome();
                    },
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 5.0,
                        spreadRadius: 0.2,
                        offset: Offset(-1, -0))
                  ],
                  borderRadius: animacionDeForma.value,
                  color: colorFondo,
                ),
              ),
            ),
          ),
          Opacity(
            opacity: animacionDesaparicion.value,
            child: Container(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16, right: 40),
                child: Icon(
                  Icons.arrow_back,
                  color: colorFuente,
                  size: 96,
                ),
              ),
            ),
          ),
        ],
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

class BotonVerEnVivo extends StatelessWidget {
  const BotonVerEnVivo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      alignment: Alignment.centerLeft,
      child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: colorsecundario,
          textColor: colorFuente,
          child: Text('En vivo'),
          onPressed: () {
            Navigator.push(
              context,
              PopUpRoute(
                child: PopUp(),
              ),
            );
          }),
    );
  }
}

//
class BotonRefrescar extends StatelessWidget {
  const BotonRefrescar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      alignment: Alignment.centerLeft,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: colorsecundario,
        textColor: colorFuente,
        child: Text('Refesh'),
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
    );
  }
}
