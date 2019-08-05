import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';

import 'PantallaMap.dart';

Color colorFondo = Color(0xff1C1818);
Color colorsecundario = Color(0xff6076E9);

class PantallaHome extends StatelessWidget {
  const PantallaHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PantallaMapa();
                },
              ),
            );
          },
          child: Text(
            '¿Dónde está la ISS? ahh?',
            style: TextStyle(
              fontSize: 28,
              color: Colors.black87.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}

class MainHome extends StatefulWidget {
  const MainHome({
    Key key,
  }) : super(key: key);

  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> with TickerProviderStateMixin {
  AnimationController controladorDeForma,
      controladorDePosicion,
      controladorDeDesaparicion;
  Animation animacionDeForma, animacionDePosicionY, animacionDesaparicion;
  Duration duaracion;

  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(myInterceptor);

    duaracion = Duration(milliseconds: 250);

    controladorDeForma = AnimationController(vsync: this, duration: duaracion);
    controladorDePosicion =
        AnimationController(vsync: this, duration: duaracion);
    controladorDeDesaparicion =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));

    animacionDesaparicion =
        Tween<double>(begin: 1, end: 0).animate(controladorDeDesaparicion)
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
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    animarEnReversa();
    print("BACK BUTTON!"); // Do some stuff.
    return true;
  }

  void animarEnReversa() async {
    controladorDeForma.reverse();
    controladorDePosicion.reverse();
    await Future.delayed(duaracion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: colorFondo,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.only(top: 40, left: 16),
            child: Opacity(
              opacity: 0.7,
              child: Container(
                width: 100,
                height: 100,
                child: Image.asset(
                  'assets/issblanca.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              "Dónde está la ISS?",
              style: TextStyle(fontSize: 32, color: Colors.white70),
            ),
          ),
          Transform.translate(
            offset: animacionDePosicionY.value,
            child: GestureDetector(
              onTap: () async {
                controladorDeDesaparicion.forward();
                controladorDeForma.forward();
                controladorDePosicion.forward();
                await Future.delayed(duaracion);
                await Future.delayed(Duration(milliseconds: 50));

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PantallaMapa();
                    },
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: animacionDeForma.value,
                  color: colorsecundario,
                ),
              ),
            ),
          ),
          Opacity(
            opacity: animacionDesaparicion.value,
            child: Container(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16, right: 52),
                child: Text(
                  '?',
                  style: TextStyle(color: Colors.white70, fontSize: 96),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
