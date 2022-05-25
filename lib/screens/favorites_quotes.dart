import 'package:final_booquote/widgets/basic_message.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../widgets/english_text.dart';
import '../provider/important_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesQuotes extends StatefulWidget {
  const FavoritesQuotes({Key key}) : super(key: key);

  @override
  _FavoritesQuotesState createState() => _FavoritesQuotesState();
}

class _FavoritesQuotesState extends State<FavoritesQuotes> {
  bool favIcon = true;

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;

    List<String> favMessages =
        Provider.of<ImportantMethods>(context).favMessage;
    List<String> favWriters = Provider.of<ImportantMethods>(context).favWriter;

    // updateFavoriteData(int index) async {
    //   SharedPreferences _pref = await SharedPreferences.getInstance();
    //   favMessages.remove(favMessages[index]);
    //   favWriters.remove(favWriters[index]);
    //   _pref.setStringList('messages', favMessages);
    //   _pref.setStringList('writers', favWriters);
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Center(child: EnglishText(text: 'Fav Quotes')),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          image: const DecorationImage(
            image: AssetImage("assets/images/app_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: favMessages.isEmpty && favWriters.isEmpty
            ? Center(
            child: Text(
              'Your favorites is empty add some quotes',
              style: TextStyle(
                fontFamily: 'Righteous',
                fontSize: 15,
                color: Provider.of<ImportantMethods>(context, listen: false).themeMode == ThemeMode.dark? Colors.white : Colors.black,
              ),
            ))
            : Padding(
          padding: const EdgeInsets.all(10),
          child: AnimationLimiter(
            child: ListView.builder(
              padding: EdgeInsets.all(_w / 30),
              physics:
              const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: favMessages.length,
              itemBuilder: (BuildContext c, int i) {
                return AnimationConfiguration.staggeredList(
                  position: i,
                  delay: const Duration(milliseconds: 100),
                  child: SlideAnimation(
                    duration: const Duration(milliseconds: 2500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    horizontalOffset: 30,
                    verticalOffset: 300.0,
                    child: FlipAnimation(
                      duration: const Duration(milliseconds: 3000),
                      curve: Curves.fastLinearToSlowEaseIn,
                      flipAxis: FlipAxis.y,
                      child: Container(
                        margin: EdgeInsets.only(bottom: _w / 20),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: BasicMessage(
                          message: favMessages[i],
                          writer: favWriters[i],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
