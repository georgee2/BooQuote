import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_booquote/data/books_data.dart';
import 'package:final_booquote/provider/important_methods.dart';
import 'package:final_booquote/widgets/arabic_text.dart';
import 'package:final_booquote/widgets/english_text.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BooksPartition extends StatefulWidget {
  const BooksPartition({Key key}) : super(key: key);

  @override
  State<BooksPartition> createState() => _BooksPartitionState();
}

class _BooksPartitionState extends State<BooksPartition> {
  final ScrollController _scrollController = ScrollController();

  int booksCurrentIndex = 0;
  int rewayatCurrentIndex = 0;

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
    final Stream<QuerySnapshot> booksLinks = FirebaseFirestore.instance.collection('Kotob').doc('914at3e4hMjkzMZA55JS')
        .collection('books').orderBy('timestamp').snapshots();
    final Stream<QuerySnapshot> rewayatLinks = FirebaseFirestore.instance.collection('Kotob').doc('914at3e4hMjkzMZA55JS')
        .collection('rewayat').orderBy('timestamp').snapshots();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          image: const DecorationImage(
            image: AssetImage("assets/images/app_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 25, bottom: 20,),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot> (
                stream: booksLinks,
                builder: (ctx, snapshot) {
                  if(snapshot.hasError){
                    return const Center(child: EnglishText(text: 'something went wrong'));
                  }
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator());
                  }
                  final data = snapshot.requireData;
                  return SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.65,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child: ArabicText(
                                  text: 'كتب',
                                  size: 25,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Expanded(
                                child: Swiper(
                                  loop: false,
                                  itemCount: BooksData().booksNames.length,
                                  viewportFraction: 0.35,
                                  scale: 0.5,
                                  pagination: const SwiperPagination(),
                                  control: SwiperControl(color: Theme.of(context).iconTheme.color),
                                  onTap: (index) async{
                                    _launchURL(data.docs[index]['link']);
                                  },
                                  itemBuilder: (ctx, index){
                                    return Column(
                                      children: [
                                        Container(
                                          child: Image.asset(
                                            BooksData().booksImagesUrl[index],
                                            height: MediaQuery.of(context).size.height * 0.3,
                                            fit: BoxFit.cover,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        ArabicText(
                                          text: BooksData().booksNames[index],
                                          size: 20,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        banner == null?
                        Divider(height: 1, color: Provider.of<ImportantMethods>(context, listen: false).themeMode == ThemeMode.dark? Colors.white : Colors.black,)
                            : SizedBox(
                          height: 50,
                          child: AdWidget(
                            ad: banner,
                          ),
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  );
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: rewayatLinks,
                builder: (ctx, snapshot) {
                  if(snapshot.hasError){
                    return const Center(child: EnglishText(text: 'something went wrong'));
                  }
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator());
                  }
                  final data = snapshot.requireData;
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.54,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: ArabicText(
                            text: 'روايات',
                            size: 25,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Expanded(
                          child: Swiper(
                            indicatorLayout: PageIndicatorLayout.COLOR,
                            loop: false,
                            itemCount: BooksData().rewayatNames.length,
                            viewportFraction: 0.35,
                            scale: 0.5,
                            pagination: const SwiperPagination(),
                            control: SwiperControl(color: Theme.of(context).iconTheme.color),
                            onTap: (index) {
                              _launchURL(data.docs[index]['link']);
                            },
                            itemBuilder: (ctx, index){
                              return Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                    ),
                                    child: Image.asset(
                                      BooksData().rewayatImagesUrl[index],
                                      height: MediaQuery.of(context).size.height * 0.3,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  ArabicText(
                                    text: BooksData().rewayatNames[index],
                                    size: 20,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch this link';
  }
}
