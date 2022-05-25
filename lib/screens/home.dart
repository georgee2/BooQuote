import 'package:final_booquote/provider/important_methods.dart';
import 'package:final_booquote/screens/feedback.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'partitions.dart';
import 'share_with_us.dart';
import '../widgets/home_partitions.dart';
import 'package:flutter/material.dart';

import 'recommendations.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List partitionNames = ['Partitions', 'Recommendations', 'Share with us', 'Feedback'];
  List partitionRoutes = [const Partitions(), const Recommendations(), const ShareWithUs(), const FeedBack()];

  int currentIndex = 0;
  final ScrollController _scrollController = ScrollController();

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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: MediaQuery.of(context).size.height * 0.1,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  HomePartitions('Quotes', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Partitions()))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  HomePartitions('Recommendations', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Recommendations()))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  HomePartitions('Share with us', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShareWithUs()))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  HomePartitions('Feedback', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FeedBack()))),
                ],
              ),
              banner == null?
              const SizedBox(height: 10,)
              : SizedBox(
                height: 50,
                child: AdWidget(ad: banner,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Expanded(
// child: ClickableListWheelScrollView(
// scrollController: _scrollController,
// itemCount: 4,
// itemHeight: 100,
// onItemTapCallback: (index) {
// Navigator.push(context,
// MaterialPageRoute(builder: (_) => partitionRoutes[index]));
// },
// child: ListWheelScrollView.useDelegate(
// controller: _scrollController,
// overAndUnderCenterOpacity: 1,
// perspective: 0.007,
// squeeze: 0.7,
// onSelectedItemChanged: (index) {
// setState(() {
// currentIndex = index;
// });
// },
// itemExtent: 100,
// childDelegate: ListWheelChildBuilderDelegate(
// childCount: 4,
// builder: (ctx, index) {
// return HomePartitions(
// partitionNames[index],
// () {
// Navigator.push(context,
// MaterialPageRoute(builder: (_) => const Partitions()));
// },
// );
// },
// ),
// ),
// ),
// ),