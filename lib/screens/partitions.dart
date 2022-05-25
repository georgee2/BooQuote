import 'package:final_booquote/provider/important_methods.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'calm_down.dart';
import 'package:flutter/material.dart';
import 'hard_time.dart';

class Partitions extends StatefulWidget {
  const Partitions({Key key}) : super(key: key);

  @override
  State<Partitions> createState() => _PartitionsState();
}

class _PartitionsState extends State<Partitions> {

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
    return Container(
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
                fit: BoxFit.cover,
                image: AssetImage('assets/images/loneliness.jpeg'),
              ),
            ),
            child: TextButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const HardTime())),
              child: const Hero(
                tag: 'to-hardTime',
                child: Text(
                  'Hard Time',
                  style: TextStyle(
                    fontFamily: 'Righteous',
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          banner == null?
          SizedBox(height: MediaQuery.of(context).size.height * 0.01,)
              : SizedBox(
            height: 50,
            child: AdWidget(ad: banner,),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.46,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/stress.jpg'),
              ),
            ),
            child: TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CalmDown())),
              child: const Hero(
                tag: 'to-calmDown',
                child: Text(
                  'Calm Down',
                  style: TextStyle(
                    fontFamily: 'Righteous',
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
