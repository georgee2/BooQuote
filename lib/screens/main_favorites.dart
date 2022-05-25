import 'package:final_booquote/provider/important_methods.dart';
import 'package:final_booquote/screens/favorites_quotes.dart';
import 'package:final_booquote/screens/favorites_songs.dart';
import 'package:final_booquote/widgets/english_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainFavorites extends StatefulWidget {
  const MainFavorites({Key key}) : super(key: key);

  @override
  State<MainFavorites> createState() => _MainFavoritesState();
}

class _MainFavoritesState extends State<MainFavorites> {

  @override
  void initState() {
    Provider.of<ImportantMethods>(context, listen: false).getFavoriteSongs();
    Provider.of<ImportantMethods>(context, listen: false).getFavoriteData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(-1, 5),
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesQuotes())),
                  child: const EnglishText(
                    text: 'fav quotes',
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(-1, 5),
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesSongs()));
                  },
                  child: const EnglishText(
                    text: 'fav songs',
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
