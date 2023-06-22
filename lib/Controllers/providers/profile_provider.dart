import 'package:image_picker/image_picker.dart';
import 'package:music_player/modals/profile_modal.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModal profileModal;

  ProfileProvider({required this.profileModal});

  pickImage() async {
    ImagePicker pick = ImagePicker();
    XFile? img = await pick.pickImage(source: ImageSource.camera);

    profileModal.userImage = File(img!.path);
    notifyListeners();
  }

  pickImage1() async {
    ImagePicker pick = ImagePicker();
    XFile? img = await pick.pickImage(source: ImageSource.gallery);

    profileModal.userImage = File(img!.path);
    notifyListeners();
  }

  saveDetails() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userImage', profileModal.userImage.path);
    prefs.setString('userName', profileModal.userName.text);

    notifyListeners();
  }

  clearDetails() async {
    profileModal.userName.clear();
    profileModal.userImage = File('');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userImage', profileModal.userImage.path);
    prefs.setString('userName', profileModal.userName.text);

    notifyListeners();
  }

}

