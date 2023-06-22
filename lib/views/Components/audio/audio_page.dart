import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:music_player/utils/list.dart';
import 'package:provider/provider.dart';
import '../../../Controllers/providers/variable_provider.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({Key? key}) : super(key: key);

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 170,
            viewportFraction: 0.8,
            autoPlay: true,
            autoPlayCurve: Curves.easeInOut,
            enlargeCenterPage: true,
          ),
          items: images
              .map(
                (e) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(e), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(
          height: 16,
        ),
        Divider(),
        Center(
          child: Text(
            "All PlayList",
          ),
        ),
        Divider(),
        Expanded(
          flex: 12,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemCount: allSongs.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    index = i;
                    Navigator.of(context).pushNamed('detail_page', arguments: allSongs[i]);
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 125,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("${allSongs[i]['image']}"),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("${allSongs[i]['name']}"),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
  @override
  void dispose() async {
    super.dispose();
    await Provider.of<SongProvider>(context, listen: false)
        .songModel
        .assetsAudioPlayer
        .dispose();
    print("----------------------------------------------------------------");
    print("----------------------------------------------------------------");
    print("----------------------------------------------------------------");
  }
}
