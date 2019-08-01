export 'package:flutter/material.dart';

import 'package:fetchdata/MixinsViewModes.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoEnVivo extends StatefulWidget {
  VideoEnVivo({Key key}) : super(key: key);

  _VideoEnVivoState createState() => _VideoEnVivoState();
}

class _VideoEnVivoState extends State<VideoEnVivo>
    with PortraitModeOnly<VideoEnVivo> {
  YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          YoutubePlayer(
            context: context,
            videoId: '4993sBLAzGA',
            flags: YoutubePlayerFlags(
              hideControls: true,
              autoPlay: true,
              isLive: true,
              showVideoProgressIndicator: true,
            ),
            onPlayerInitialized: (controller) {
              _controller = controller;
            },
          ),
          MaterialButton(
            child: Icon(Icons.fullscreen),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FullScreenVideo();
              }));
            },
          )
        ],
      ),
    );
  }
}

class FullScreenVideo extends StatefulWidget {
  @override
  _FullScreenVideoState createState() => _FullScreenVideoState();
}

class _FullScreenVideoState extends State<FullScreenVideo>
    with PortraitModeOnly<FullScreenVideo> {
  YoutubePlayerController _controller;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: YoutubePlayer(
            context: context,
            videoId: '4993sBLAzGA',
            flags: YoutubePlayerFlags(
              hideControls: true,
              autoPlay: true,
              isLive: true,
              showVideoProgressIndicator: true,
            ),
            progressColors: ProgressColors(
              backgroundColor: Colors.amber,
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
            onPlayerInitialized: (controller) {
              _controller = controller;
              _controller.enterFullScreen();
            }),
      ),
    );
  }
}
