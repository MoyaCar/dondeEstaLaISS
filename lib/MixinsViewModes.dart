import 'package:fetchdata/Vivo.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

mixin PortraitModeOnly<T extends StatefulWidget> on State<T> {
  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    return null;
  }

  @override
  void dispose() {
    _enableRotations();
    super.dispose();
  }
}
mixin LandscapeModeOnly on StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _landscapeModeOnly();
    return null;
  }

}

void _portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
}

void _landscapeModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

void _enableRotations() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
}
