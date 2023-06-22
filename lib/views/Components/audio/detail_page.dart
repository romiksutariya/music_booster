import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:music_player/Controllers/providers/variable_provider.dart';
import 'package:provider/provider.dart';
import '../../../utils/list.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<SongProvider>(context, listen: false)
        .songModel
        .assetsAudioPlayer
        .open(
          Audio(allSongs[index]['song']),
          showNotification: true,
          loopMode: LoopMode.playlist,
          autoStart: Provider.of<SongProvider>(context, listen: false)
              .songModel
              .isPlay,
        );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
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
              StreamBuilder(
                stream: Provider.of<SongProvider>(context)
                    .songModel
                    .assetsAudioPlayer
                    .currentPosition,
                builder: (context, snapshot) {
                  Provider.of<SongProvider>(context)
                          .songModel
                          .currentSliderValue =
                      (snapshot.data != null)
                          ? snapshot.data!
                          : const Duration(seconds: 0);

                  try {
                    Provider.of<SongProvider>(context).songModel.totalDuration =
                        Provider.of<SongProvider>(context, listen: false)
                            .songModel
                            .assetsAudioPlayer
                            .current
                            .value
                            ?.audio
                            .duration;
                  } catch (e) {
                    Provider.of<SongProvider>(context, listen: false)
                        .songModel
                        .totalDuration = const Duration(seconds: 0);
                  }

                  return Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 180,
                          ),
                          CircleAvatar(
                            foregroundImage: AssetImage("${data['image']}"),
                            radius: 160,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Slider(
                        min: 0,
                        max: Provider.of<SongProvider>(context, listen: false)
                            .songModel
                            .totalDuration!
                            .inSeconds
                            .toDouble(),
                        value: Provider.of<SongProvider>(context)
                            .songModel
                            .currentSliderValue
                            .inSeconds
                            .toDouble(),
                        onChanged: (val) {
                          Provider.of<SongProvider>(context, listen: false)
                              .songModel
                              .assetsAudioPlayer
                              .seek(
                                Duration(seconds: val.toInt()),
                              );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Provider.of<SongProvider>(context)
                              .songModel
                              .currentSliderValue
                              .toString()
                              .split('.')[0]),
                          Text(Provider.of<SongProvider>(context, listen: false)
                              .songModel
                              .totalDuration!
                              .toString()
                              .split('.')[0]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () async {
                              if (Provider.of<SongProvider>(context,
                                  listen: false)
                                  .songModel
                                  .isPlay ==
                                  false) {
                                Provider.of<SongProvider>(context,
                                    listen: false)
                                    .playSong();
                              }

                              await Provider.of<SongProvider>(context,
                                  listen: false)
                                  .songModel
                                  .assetsAudioPlayer
                                  .previous();
                            },
                            icon: const Icon(Icons.skip_previous),
                          ),
                          IconButton(
                            onPressed: () async {
                              Provider.of<SongProvider>(context, listen: false)
                                  .playSong();
                              await Provider.of<SongProvider>(context, listen: false)
                                  .songModel
                                  .assetsAudioPlayer
                                  .playOrPause();
                            },
                            icon:
                            (Provider.of<SongProvider>(context).songModel.isPlay)
                                ? const Icon(Icons.pause_circle_outline,size: 40,)
                                : const Icon(Icons.play_circle_outline,size: 40,),
                          ),
                          IconButton(
                            onPressed: () async {
                              if (Provider.of<SongProvider>(context,
                                  listen: false)
                                  .songModel
                                  .isPlay ==
                                  false) {
                                Provider.of<SongProvider>(context,
                                    listen: false)
                                    .playSong();
                              }

                              await Provider.of<SongProvider>(context,
                                  listen: false)
                                  .songModel
                                  .assetsAudioPlayer
                                  .next();
                            },
                            icon: const Icon(Icons.skip_next),
                          ),
                          IconButton(
                            onPressed: () async {
                              Provider.of<SongProvider>(context, listen: false)
                                  .muteSong();
                              (Provider.of<SongProvider>(context, listen: false)
                                  .songModel
                                  .isMute)
                                  ? await Provider.of<SongProvider>(context,
                                  listen: false)
                                  .songModel
                                  .assetsAudioPlayer
                                  .setVolume(0)
                                  : await Provider.of<SongProvider>(context,
                                  listen: false)
                                  .songModel
                                  .assetsAudioPlayer
                                  .setVolume(1);
                            },
                            icon: (Provider.of<SongProvider>(context,
                                listen: false)
                                .songModel
                                .isMute)
                                ? const Icon(Icons.volume_off)
                                : const Icon(Icons.volume_up),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await Provider.of<SongProvider>(context, listen: false)
        .songModel
        .assetsAudioPlayer
        .dispose();
  }
}
