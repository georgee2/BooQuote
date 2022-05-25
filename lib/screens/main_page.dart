import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:final_booquote/screens/main_favorites.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/important_methods.dart';
import 'data_screen/daily_message.dart';
import 'info.dart';
import '../widgets/english_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

import '../main.dart';
import 'home.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final keyIsFirstLoaded = 'is_first_loaded';
  int page = 2;

  @override
  void initState() {
    // Provider.of<ImportantMethods>(context, listen: false).getFavoriteData();
    // Provider.of<ImportantMethods>(context, listen: false).getFavoriteSongs();
    Workmanager().registerPeriodicTask(
      'firebaseWorkManager',
      'addMessage',
      frequency: const Duration(days: 1),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(child: EnglishText(text: '${appBarTitle()}')),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          image: const DecorationImage(
            image: AssetImage("assets/images/app_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: currentPage(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: page,
        height: 60,
        backgroundColor: Colors.transparent,
        color: Theme.of(context).primaryColor,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        letIndexChange: (index) => true,
        items: [
          Icon(
            Icons.favorite,
            color: Theme.of(context).iconTheme.color,
          ),
          Icon(
            Icons.settings,
            color: Theme.of(context).iconTheme.color,
          ),
          Icon(
            Icons.home,
            color: Theme.of(context).iconTheme.color,
          ),
          Icon(
            Icons.message_outlined,
            color: Theme.of(context).iconTheme.color,
          ),
          Icon(
            Icons.info_outline,
            color: Theme.of(context).iconTheme.color,
          ),
        ],
      ),
    );
  }

  //current page for bottom nav bar
  currentPage() {
    if (page == 0) {
      //favorite screen
      return const MainFavorites();
    } else if (page == 1) {
      //setting screen
      return settingScreen();
    } else if (page == 2) {
      //home screen
      return const Home();
    } else if (page == 3) {
      //daily messages screen
      return const DailyMessage();
    } else if (page == 4) {
      //info screen
      return const AboutScreen();
    }
  }

  appBarTitle() {
    if (page == 0) {
      //favorite screen
      return 'Favorites';
    } else if (page == 1) {
      //setting screen
      return 'Settings';
    } else if (page == 2) {
      //home screen
      return 'Home';
    } else if (page == 3) {
      //daily messages screen
      return 'Daily Message';
    } else if (page == 4) {
      //info screen
      return 'About Us';
    }
  }

  settingScreen() {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dark mode',
                  style: TextStyle(
                    fontFamily: 'Righteous',
                    fontSize: 20,
                    color: Provider.of<ImportantMethods>(context, listen: false).themeMode == ThemeMode.dark? Colors.white : Colors.black,
                  ),
                ),
                Switch(
                  activeColor: Colors.blue,
                  activeTrackColor: Colors.black38,
                  inactiveTrackColor: Colors.grey,
                  inactiveThumbColor: Colors.blue,
                  value: Provider.of<ImportantMethods>(context, listen: true)
                          .themeMode ==
                      ThemeMode.dark,
                  onChanged: (bool value) {
                    Provider.of<ImportantMethods>(context, listen: false)
                        .toggleTheme(value);
                    StorageManager.saveData(value);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontFamily: 'Righteous',
                      fontSize: 20,
                      color: Provider.of<ImportantMethods>(context, listen: false).themeMode == ThemeMode.dark? Colors.white : Colors.black,
                    ),
                  ),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const AuthScreen()));
                  },
                ),
                GestureDetector(
                  child: Icon(
                    Icons.logout,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const AuthScreen()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showDialogIfFirstLoaded(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    if (isFirstLoaded == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Row(
              children: const [
                Icon(Icons.warning, color: Colors.red,),
                SizedBox(width: 3,),
                Text("Warning"),
              ],
            ),
            content: const Text("Please restart the app"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  prefs.setBool(keyIsFirstLoaded, false);
                },
              ),
            ],
          );
        },
      );
    }
  }
}
