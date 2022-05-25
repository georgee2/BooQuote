import 'package:final_booquote/widgets/basic_songs.dart';

import '../widgets/english_text.dart';
import '../provider/important_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesSongs extends StatefulWidget {
  const FavoritesSongs({Key key}) : super(key: key);

  @override
  _FavoritesSongsState createState() => _FavoritesSongsState();
}

class _FavoritesSongsState extends State<FavoritesSongs> {
  bool favIcon = true;


  @override
  Widget build(BuildContext context) {
    List<Map> favSongs = Provider.of<ImportantMethods>(context).totalFavSongs;

    List<String> favSongsLinks =
        Provider.of<ImportantMethods>(context).favSongsLinks;

    updateFavoriteData(int index) async {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      favSongsLinks.remove(favSongsLinks[index]);
      _pref.setStringList('songsLinks', favSongsLinks);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Center(child: EnglishText(text: 'Fav Songs')),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          image: const DecorationImage(
            image: AssetImage("assets/images/app_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: favSongsLinks.isEmpty
            ? const Center(
            child: Text(
              'Your favorites is empty add some songs',
              style: TextStyle(fontSize: 15),
            ))
            : Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: favSongsLinks.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: BasicSong(
                      songLink: favSongs[index]['link'],
                      songTime: favSongs[index]['time'],
                      songName: favSongs[index]['name'],
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              );
            },
          ),
        ),

      ),
    );
  }
}
