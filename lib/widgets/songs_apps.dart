import 'package:final_booquote/screens/recom/song_band.dart';
import 'package:final_booquote/screens/recom/songs_links.dart';
import 'package:final_booquote/widgets/english_text.dart';
import 'package:flutter/material.dart';

class SongsApps extends StatelessWidget {
  final String title;
  final String imagePath;
  final double width;
  final double height;
  final String appType;

  const SongsApps({Key key, this.title, this.imagePath, this.width, this.height, this.appType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SongBand(appName: appType, logoApp: imagePath,))),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        child: Row(
          children: [
            Image.asset(imagePath, width: width, height: height,),
            const SizedBox(width: 10,),
            EnglishText(text: title,),
          ],
        ),
      ),
    );
  }
}
