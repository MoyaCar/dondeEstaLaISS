
import 'package:flutter/material.dart';

import 'PantallaMap.dart';

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
            '¿Dónde está la ISS?',
            style: TextStyle(
                fontFamily: 'RussoOne',
                fontSize: 28,
                color: Colors.black87.withOpacity(0.7)),
          ),
        ),
      ),
    );
  }
}
