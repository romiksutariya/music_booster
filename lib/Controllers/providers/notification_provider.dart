import 'package:music_player/modals/notification_modal.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider extends ChangeNotifier{

  notificationModal notificationmodal;

  NotificationProvider({
    required this.notificationmodal
  });

  void changeNotification()async{
    notificationmodal.isNotification = !notificationmodal.isNotification;

    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('isNotification', notificationmodal.isNotification);
  }
}