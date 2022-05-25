import 'package:auto_direction/auto_direction.dart';
import 'package:final_booquote/provider/important_methods.dart';
import 'package:final_booquote/widgets/arabic_text.dart';
import 'package:final_booquote/widgets/english_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareWithUs extends StatefulWidget {
  const ShareWithUs({Key key}) : super(key: key);

  @override
  _ShareWithUsState createState() => _ShareWithUsState();
}

class _ShareWithUsState extends State<ShareWithUs> {
  final _controller = TextEditingController();

  bool isRTL = false;
  static String text = "";

  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      appBar: AppBar(
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
          ),
          onTap: () => Navigator.pop(context),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: const EnglishText(text: 'Share with us',),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          image: const DecorationImage(
            image: AssetImage("assets/images/app_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ArabicText(text: 'شاركنا بكتباتك', size: 25,),
              const SizedBox(height: 15),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(width: 3, color: Theme.of(context).primaryColor),
                  ),
                  child: AutoDirection(
                    onDirectionChange: (isRTL) {
                      setState(() {
                        this.isRTL = isRTL;
                      });
                    },
                    text: text,
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: _controller,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintTextDirection: TextDirection.rtl,
                          hintText: "اكتب هنا...",
                          hintStyle: TextStyle(
                            color: Provider.of<ImportantMethods>(context, listen: false).themeMode == ThemeMode.dark? Colors.white : Colors.black,
                            fontFamily: 'ElMessiri',
                            fontSize: 20,
                          ),
                          border: const OutlineInputBorder(),
                      ),
                      onChanged: (str) {
                        setState(() {
                          text = str;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  if (text.length > 9) {
                    _launchURL('tawfikgeorge3@gmail.com', 'BooQuote Share', text);
                    _controller.clear();
                  } else {
                    return fToast.showToast(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            text.isEmpty? 'Enter some text' : 'This message is too short', style: const TextStyle(fontSize: 18),),
                      ),
                      gravity: ToastGravity.BOTTOM,
                      toastDuration: const Duration(seconds: 2),
                    );
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    //border: Border.all(width: 3, color: Theme.of(context).primaryColor),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const EnglishText(text: 'send',),
                      const SizedBox(width: 5,),
                      Icon(
                        Icons.send,
                        color: Theme.of(context).iconTheme.color,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              banner == null?
                  const SizedBox(height: 10,)
                  : SizedBox(
                height: 50,
                child: AdWidget(
                  ad: banner,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
