import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const YoutubeVid(),
    );
  }
}

class YoutubeVid extends StatefulWidget {
  const YoutubeVid({super.key});

  @override
  State<YoutubeVid> createState() => _YoutubeVidState();
}

class _YoutubeVidState extends State<YoutubeVid> {
  final _controller = YoutubePlayerController(
    initialVideoId: 'SlzK9fFFO0M',
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
      hideThumbnail: true,
    ),
  );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: YoutubePlayerBuilder(
        // onExitFullScreen: () {
        //   // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        //   SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        // },
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          aspectRatio: 16 / 9,
          bottomActions: [
            RemainingDuration(),
            ProgressBar(
              isExpanded: true,
              colors: ProgressBarColors(
                  playedColor: Colors.red,
                  handleColor: Colors.redAccent,
                  bufferedColor: Colors.grey),
            ),
            FullScreenButton(),
            PlaybackSpeedButton()
          ],
        ),
        builder: (context, player) {
          return Column(
            children: [
              player,
              IconButton(
                  onPressed: () {
                    _controller.play();
                  },
                  icon: Icon(Icons.play_arrow))
            ],
          );
        },
      )),
    );
  }
}
