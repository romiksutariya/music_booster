import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/views/screens/home_page.dart';
import 'package:music_player/views/screens/setting_page.dart';
import 'package:provider/provider.dart';
import 'package:music_player/views/screens/splash_screen.dart';
import 'package:music_player/views/Components/audio/detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:music_player/views/Components/video/vdodetail_page.dart';
import 'Controllers/providers/notification_provider.dart';
import 'Controllers/providers/profile_provider.dart';
import 'Controllers/providers/theme_provider.dart';
import 'Controllers/providers/variable_provider.dart';
import 'modals/notification_modal.dart';
import 'modals/profile_modal.dart';
import 'modals/theme_modals.dart';
import 'modals/variable.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isdark = prefs.getBool('isdark') ?? false;
  bool isnotification = prefs.getBool('isnotification') ?? false;
  String userImage = prefs.getString('userImage') ?? '';
  String userName = prefs.getString('userName') ?? '';

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SongProvider(
            songModel: SongModel(
              isPlay: false,
              isMute: false,
              assetsAudioPlayer: AssetsAudioPlayer(),
              currentSliderValue: const Duration(seconds: 0),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(
            profileModal: ProfileModal(
              userImage: File(userImage),
              userName: TextEditingController(text: userName),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationProvider(
            notificationmodal: notificationModal(
              isNotification: isnotification,
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => themeProvider(
            thememodel: themeModel(
              isDark: isdark,
            ),
          ),
        ),
      ],
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          themeMode: (Provider.of<themeProvider>(context).thememodel.isDark == false)
              ? ThemeMode.light
              : ThemeMode.dark,
          routes: {
            '/': (context) => SplashScreen(),
            'home_page': (context) => HomePage(),
            'detail_page': (context) => DetailsPage(),
            'vdodetail_page': (context) => VdoDtailsPage(),
            'setting_page': (context) => SettingPage(),
          },
        );
      },
    ),
  );
}
