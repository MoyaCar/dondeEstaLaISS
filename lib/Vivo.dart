export 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoEnVivo extends StatefulWidget {
  VideoEnVivo({Key key}) : super(key: key);

  _VideoEnVivoState createState() => _VideoEnVivoState();
}

class _VideoEnVivoState extends State<VideoEnVivo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YoutubePlayer(
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
      ),
    );
  }
}
