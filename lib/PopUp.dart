import 'package:fetchdata/MixinsViewModes.dart';
import 'package:fetchdata/Vivo.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

class PopUp extends StatefulWidget {
  PopUp({Key key}) : super(key: key);

  _PopUpState createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> with PortraitModeOnly<PopUp> {
  Color colorFuente = Colors.white.withOpacity(0.8);
  Color colorFondo = Color(0xff1C1818);
  Color colorsecundario = Color(0xff6076E9);
  Color colorfondoPopUp = Colors.black87;
  YoutubePlayerController _playerController;
  bool _estaEnPantallaCompleta = false;

  salirDePantallaCompleta() {
    _playerController.exitFullScreen();
    _estaEnPantallaCompleta = false;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Center(
            child: Stack(
              fit: StackFit.loose,
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.volume_mute, color: colorFuente,),
                        onPressed: () {},
                      ),
                      IconButton(
                          icon: Icon(Icons.fullscreen, color: colorFuente,),
                          onPressed: () {
                            _estaEnPantallaCompleta = true;
                            _playerController.enterFullScreen();
                          }),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: YoutubePlayer(
                    context: context,
                    videoId: '4993sBLAzGA',
                    flags: YoutubePlayerFlags(
                      hideControls: true,
                      autoPlay: true,
                      isLive: true,
                      showVideoProgressIndicator: true,
                    ),
                    onPlayerInitialized: (controller) {
                      _playerController = controller;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 64),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          mini: true,
          onPressed: () {
            _estaEnPantallaCompleta
                ? salirDePantallaCompleta()
                : Navigator.pop(context);
          },
          child: Icon(Icons.close),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }
}
