import 'package:final_booquote/provider/important_methods.dart';
import 'package:final_booquote/screens/recom/book_partition.dart';
import 'package:final_booquote/screens/recom/song_partition.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class Recommendations extends StatefulWidget {
  const Recommendations({Key key}) : super(key: key);

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {

  //banner ad
  BannerAd banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<ImportantMethods>(context);
    adState.initialization.then((value) {
      setState(() {
        banner = BannerAd(
          size: AdSize.banner,
          adUnitId: adState.bannerAdUnitId,
          listener: adState.adListener,
          request: const AdRequest(),
        )..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          image: const DecorationImage(
            image: AssetImage("assets/images/app_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.46,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/books.jpg'),
                ),
              ),
              child: TextButton(
                child: const Text(
                  'Books',
                  style: TextStyle(
                    fontFamily: 'Righteous',
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Provider.of<ImportantMethods>(context, listen: false).createInterstitial();
                  Provider.of<ImportantMethods>(context, listen: false).showInterstitial();
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const BooksPartition()));
                },
              ),
            ),
            banner == null?
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,)
            : SizedBox(
              height: 50,
              child: AdWidget(
                ad: banner,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.46,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage('assets/images/songs/songs.jpg'),
                ),
              ),
              child: TextButton(
                child: const Text(
                  'Music',
                  style: TextStyle(
                    fontFamily: 'Righteous',
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Provider.of<ImportantMethods>(context, listen: false).createInterstitial();
                  Provider.of<ImportantMethods>(context, listen: false).showInterstitial();
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SongPartition()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
