import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controllers/providers/theme_provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Settings",
              style: TextStyle(fontSize: 50),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50)
                ),
                prefixIcon: Icon(Icons.search,size: 30,),
                hintText: "Enter Your Name...",
                hintStyle: TextStyle(
                  fontSize: 20,
                ),
                border: InputBorder.none,
              ),
            ),
            ListTile(
              leading: Icon(Icons.volume_up),
              title: Text("sound & Vibration"),
              subtitle: Text("Volume"),
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text("Security"),
              subtitle: Text("Sapp security"),
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text("Privacy"),
              subtitle: Text("personal data"),
            ),
            ListTile(
              leading: Icon(Icons.sunny_snowing),
              title: Text("Theme"),
              subtitle: Text("Change Theme"),
              trailing: Switch(
                value:
                (Provider.of<themeProvider>(context).thememodel.isDark),
                onChanged: (val) {
                  Provider.of<themeProvider>(context, listen: false)
                      .changetheme();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
