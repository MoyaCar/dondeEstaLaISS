import 'package:fetchdata/FullScreenIss.dart';
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

  YoutubePlayerController _playerController;
@override
  void initState() {
 
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
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
                      icon: Icon(Icons.volume_mute),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.fullscreen),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              
                              return FullScreenIss();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: YoutubePlayer(
                  context: context,
                  videoId: '4993sBLAzGA',
                  flags: YoutubePlayerFlags(
                    
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
    );
  }
}
