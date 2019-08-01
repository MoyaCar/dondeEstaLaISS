import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

class FullScreenIss extends StatefulWidget {
  const FullScreenIss({Key key}) : super(key: key);

  @override
  _FullScreenIssState createState() => _FullScreenIssState();
}

class _FullScreenIssState extends State<FullScreenIss> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
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
            ),
          ),
        ],
      ),
    );
  }
}
