import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_booquote/data/songs_data.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImportantMethods with ChangeNotifier {
  //google adsense
  Future<InitializationStatus> initialization;

  ImportantMethods(this.initialization);

  String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-5844375764287739/2573950655'
      : 'ca-app-pub-3940256099942544/2934735716';

  String get interstitialAdUnitId => 'ca-app-pub-5844375764287739/2517216117';

  InterstitialAd _interstitialAd;
  int numOfShow = 0;

  void createInterstitial() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _interstitialAd = ad;
            numOfShow = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            _interstitialAd = null;
            numOfShow+1;

            if(numOfShow <= 2) createInterstitial();
          }
      ),
    );
  }
  void showInterstitial() {
    if(_interstitialAd == null) return;

    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad){
        print('interstitial showed');
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('interstitial disposed');
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad load failed $error');
        ad.dispose();
        createInterstitial();
      },
    );

    _interstitialAd.show();
    _interstitialAd = null;
  }

  BannerAdListener get adListener => _adListener;

  final BannerAdListener _adListener = BannerAdListener(
    onAdLoaded: (ad) => print('Ad Loaded: ${ad.adUnitId}'),
    onAdClosed: (ad) => print('Ad Loaded: ${ad.adUnitId}'),
    onAdFailedToLoad: (ad, error) =>
        print('Ad Loaded: ${ad.adUnitId}, $error.'),
    onAdOpened: (ad) => print('Ad Loaded: ${ad.adUnitId}'),
  );

  ///handle favorites
  List<String> favMessage = [];
  List<String> favWriter = [];

  getFavoriteData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    favMessage = (_pref.getStringList('messages') ?? []);
    favWriter = _pref.getStringList('writers') ?? [];
  }

  List<String> favSongsLinks = [];
  List<Map> totalSongs = [];
  List<Map> totalFavSongs = [];

  getFavoriteSongs() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    favSongsLinks = _pref.getStringList('songsLinks') ?? [];
    totalSongs = SongsData().soundCloud + SongsData().spotify + SongsData().anghami + SongsData().youtube;
    favSongsLinks == []
        ? totalFavSongs = []
        : totalFavSongs.addAll(
            totalSongs.where(
                  (element) => favSongsLinks.contains(
                    element['link'],
                  ),
                ),
          );
  }

  ///handle dark and light mode
  //darkMode Value
  // bool darkMode;
  // Color topColor;
  // Color downColor;
  // Color textColor;
  // Color iconColor;
  //
  // setDarkValue(bool newValue) async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   _prefs.setBool("dark", newValue);
  //   darkMode = newValue;
  //   notifyListeners();
  // }
  //
  // getDarkValue() async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   darkMode = _prefs.getBool("dark") == false ? false : true;
  //   notifyListeners();
  // }
  //
  // setAppTheme() async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   if (_prefs.getBool("dark") == false) {
  //     topColor = Colors.grey[300];
  //     downColor = Colors.grey[100];
  //     textColor = Colors.black;
  //     iconColor = Colors.black;
  //   } else {
  //     topColor = Colors.blueGrey[700];
  //     downColor = Colors.blueGrey[800];
  //     textColor = Colors.white;
  //     iconColor = Colors.white;
  //   }
  //   notifyListeners();
  // }

  //new way for dark mode
  ThemeMode _themeMode = ThemeMode.light;

  get themeMode => _themeMode;

  toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
  
  Map<String, dynamic> books;
  List<String> bLinks = [];
  void getBookLinks(){
    FirebaseFirestore.instance.collection('Kotob').doc('914at3e4hMjkzMZA55JS').collection('books').get().then((value) async{
      value.docs.forEach((element) async{
        books.addAll(element.data());
        books.forEach((key, value) {bLinks.addAll(value);});
        SharedPreferences _pref = await SharedPreferences.getInstance();
        _pref.setStringList('books', bLinks);
      });
      SharedPreferences _pref = await SharedPreferences.getInstance();
      print(_pref.getStringList('books'));
    });
  }

}
class StorageManager {
  static void saveData(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkTheme', value);
  }

  static Future<bool> readData() async {
    final prefs = await SharedPreferences.getInstance();
    bool obj = prefs.get('darkTheme');
    return obj;
  }

  static Future<bool> deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('darkTheme');
  }
}
