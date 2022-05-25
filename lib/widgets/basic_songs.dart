import 'package:final_booquote/provider/important_methods.dart';
import 'package:final_booquote/widgets/arabic_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'english_text.dart';

class BasicSong extends StatefulWidget {
  final String songName;
  final String songTime;
  final String songLink;
  final int index;
  // final int listLength;

  const BasicSong({Key key, this.songName, this.index, this.songTime, this.songLink,})
      : super(key: key);

  @override
  State<BasicSong> createState() => _BasicSongState();
}

class _BasicSongState extends State<BasicSong> {
  List<String> favSongs = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Provider.of<ImportantMethods>(context, listen: false).themeMode == ThemeMode.dark?
          Colors.transparent
          : Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //EnglishText(text: "${index+1} .", size: 15,),
            IconButton(
              onPressed: (){
                _launchURL(widget.songLink);
              },
              icon: const Icon(Icons.play_arrow_sharp),),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: ArabicText(text: widget.songName,),
            ),
            const SizedBox(width: 10,),
            EnglishText(text: widget.songTime,),
            IconButton(
              onPressed: (){
                setState(() {
                  checkSongExist();
                });
              },
              icon: Icon(Provider.of<ImportantMethods>(context).favSongsLinks.contains(widget.songLink)?
              Icons.favorite : Icons.favorite_outline),
            ),
            IconButton(
              onPressed: (){
                Share.share('#Shared_from_(BooQuote)_app\n' + widget.songLink);
              },
              icon: const Icon(Icons.share),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch this link';
  }

  checkSongExist() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    List<String> songs = [];
    _pref.getStringList('songsLinks') == null
        ? songs = []
        : songs = _pref.getStringList('songsLinks');
    if (songs.contains(widget.songLink)) {
      setState(() {
        songs.remove(widget.songLink);
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Removed from favorites'),
        duration: Duration(milliseconds: 1500),
      ));
    } else {
      setState(() {
        songs.add(widget.songLink);
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('added to favorites'),
        duration: Duration(milliseconds: 1500),
      ));
    }
    //favSongs.map((e) => !songs.contains(e) ?? songs.add(e));
    _pref.setStringList('songsLinks', songs);
    Provider.of<ImportantMethods>(context, listen: false).favSongsLinks = songs;
  }
}