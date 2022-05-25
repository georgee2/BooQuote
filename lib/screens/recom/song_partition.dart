import 'package:final_booquote/provider/important_methods.dart';
import 'package:final_booquote/widgets/english_text.dart';
import 'package:final_booquote/widgets/songs_apps.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class SongPartition extends StatefulWidget {
  const SongPartition({Key key}) : super(key: key);

  @override
  State<SongPartition> createState() => _SongPartitionState();
}

class _SongPartitionState extends State<SongPartition> {
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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          image: const DecorationImage(
            image: AssetImage("assets/images/app_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const EnglishText(
              text: 'Music is freedom',
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                          child: SongsApps(
                            title: 'SoundCloud',
                            imagePath: 'assets/images/soundcloud_logo.png',
                            height: MediaQuery.of(context).size.height * 0.07,
                            appType: 'Soundcloud',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                          child: SongsApps(
                            title: 'Spotify',
                            imagePath: 'assets/images/spotify_logo.png',
                            height: MediaQuery.of(context).size.height * 0.07,
                            appType: 'Spotify',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                          child: SongsApps(
                            title: "YouTube",
                            imagePath: 'assets/images/youtube_logo.png',
                            height: MediaQuery.of(context).size.height * 0.07,
                            appType: 'Youtube',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                          child: SongsApps(
                            title: "Anghami",
                            imagePath: 'assets/images/anghami_logo.png',
                            height: MediaQuery.of(context).size.height * 0.07,
                            appType: 'Anghami',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            banner == null
                ? const SizedBox(
                    height: 10,
                  )
                : SizedBox(
                    height: 50,
                    child: AdWidget(
                      ad: banner,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
