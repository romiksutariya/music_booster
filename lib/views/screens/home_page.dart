import 'package:flutter/material.dart';
import 'package:music_player/views/Components/audio/audio_page.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:music_player/views/Components/video/video_page.dart';
import 'package:provider/provider.dart';

import '../../Controllers/providers/notification_provider.dart';
import '../../Controllers/providers/profile_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: 0,
            bottom: TabBar(
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              controller: tabController,
              tabs: [
                Tab(
                  text: "Audio",
                ),
                Tab(
                  text: "Video",
                ),
              ],
            ),
          ),
          body: SliderDrawer(
            appBar: SliderAppBar(
              title: Text(
                "Media Booster",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            slider: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                "Your Image Source",
                              ),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        Provider.of<ProfileProvider>(context,
                                                listen: false)
                                            .pickImage();
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    child: Text("Camera"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        Provider.of<ProfileProvider>(context,
                                                listen: false)
                                            .pickImage1();
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    child: Text("Gallery"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 60,
                          foregroundImage: FileImage(
                              Provider.of<ProfileProvider>(context)
                                  .profileModal
                                  .userImage),
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: Provider.of<ProfileProvider>(context)
                        .profileModal
                        .userName,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Enter Your Name...",
                      hintStyle: TextStyle(
                        fontSize: 20,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Provider.of<ProfileProvider>(context, listen: false)
                              .saveDetails();
                        },
                        child: Text("SAVE"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Provider.of<ProfileProvider>(context, listen: false)
                              .clearDetails();
                        },
                        child: Text("CLEAR"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        'home_page',
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.home,
                          size: 25,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Home",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Provider.of<ProfileProvider>(context, listen: false)
                            .pickImage1();
                        Navigator.of(context).pop();
                      });
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.add_circle,
                          size: 25,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Add Post",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.notifications_active,
                        size: 25,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Notifications",
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Switch(
                        value: (Provider.of<NotificationProvider>(context)
                            .notificationmodal
                            .isNotification),
                        onChanged: (val) {
                          Provider.of<NotificationProvider>(context,
                                  listen: false)
                              .changeNotification();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.favorite,
                        size: 25,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Likes",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('setting_page');
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.settings,
                          size: 25,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Settings",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout,
                          size: 25,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          "Log Out",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 18,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      AudioPage(),
                      VideoPage(),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
