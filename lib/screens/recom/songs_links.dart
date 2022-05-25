import 'package:final_booquote/data/songs_data.dart';
import 'package:final_booquote/provider/important_methods.dart';
import 'package:final_booquote/widgets/basic_songs.dart';
import 'package:final_booquote/widgets/english_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongsLinks extends StatefulWidget {
  final String appType;
  final String bandName;
  final String bandLogo;

  const SongsLinks({Key key, this.appType, this.bandName, this.bandLogo}) : super(key: key);

  @override
  _SongsLinksState createState() => _SongsLinksState();
}

class _SongsLinksState extends State<SongsLinks> {
  //basic
  List<Map> songs = [];

  @override
  Widget build(BuildContext context) {
    if (widget.appType == "Spotify") {
      songs.addAll(SongsData().spotify.where((element) => element['band'] == widget.bandName));
    } else if (widget.appType == "Soundcloud") {
      songs.addAll(SongsData().soundCloud.where((element) => element['band'] == widget.bandName));
    } else if (widget.appType == "Anghami") {
      songs.addAll(SongsData().anghami.where((element) => element['band'] == widget.bandName));
    } else if (widget.appType == "Youtube") {
      songs.addAll(SongsData().youtube.where((element) => element['band'] == widget.bandName));
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          image: const DecorationImage(
            image: AssetImage('assets/images/app_background.png'),
            fit: BoxFit.cover
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15),
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(-1, 15),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(widget.bandLogo),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Provider.of<ImportantMethods>(context, listen: false).themeMode == ThemeMode.dark?
            EnglishText(
              text: 'Playlist ${songs.length} track',
            )
            : Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: EnglishText(
                text: 'Playlist ${songs.length} track',
              ),
            ),
            const SizedBox(height: 5,),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return BasicSong(
                    songLink: songs[index]['link'],
                    songName: songs[index]['name'],
                    songTime: songs[index]['time'],
                    index: index,
                    // listLength: songs.length,
                  );
                },
                itemCount: songs.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
