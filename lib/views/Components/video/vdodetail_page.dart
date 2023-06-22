import 'package:flutter/material.dart';
import 'package:music_player/utils/list.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VdoDtailsPage extends StatefulWidget {
  const VdoDtailsPage({Key? key}) : super(key: key);

  @override
  State<VdoDtailsPage> createState() => _VdoDtailsPageState();
}

class _VdoDtailsPageState extends State<VdoDtailsPage> {

  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.asset(allVideos[index]['video'])
      ..initialize().then((value) => setState(() {}));
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 4 / 2,
        autoPlay: false,
        allowFullScreen: true
    );
  }

  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> data1 =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Divider(),
              Text(
                "Videos",
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              AspectRatio(
                aspectRatio: 4 / 2,
                child: Chewie(
                  controller: chewieController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }
}