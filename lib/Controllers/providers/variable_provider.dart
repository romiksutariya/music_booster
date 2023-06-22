import 'package:flutter/material.dart';
import 'package:music_player/modals/variable.dart';

class SongProvider extends ChangeNotifier {
  SongModel songModel;

  SongProvider({required this.songModel});

  playSong() async {
    songModel.isPlay = !songModel.isPlay;
    notifyListeners();
  }

  muteSong() {
    songModel.isMute = !songModel.isMute;
    notifyListeners();
  }
}
