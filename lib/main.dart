import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_booquote/provider/theme_constants.dart';
import 'package:final_booquote/widgets/english_text.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/important_methods.dart';
import 'screens/main_page.dart';
import 'widgets/text_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import 'data/daily_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final initFuture = MobileAds.instance.initialize();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImportantMethods(initFuture)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Provider.of<ImportantMethods>(context, listen: false)
        .removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    Provider.of<ImportantMethods>(context, listen: false)
        .addListener(themeListener);
    StorageManager.readData();
    assignDarkValue();
    super.initState();
  }

  assignDarkValue() async {
    final prefs = await SharedPreferences.getInstance();
    Provider.of<ImportantMethods>(context, listen: true)
        .toggleTheme(prefs.get('darkTheme') == null || true? true : false);
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: Provider.of<ImportantMethods>(context).themeMode,
      debugShowCheckedModeBanner: false,
      title: 'BooQuote',
      home: const SplashScreen(),
    );
  }
}


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;

    Future.delayed(const Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => user == null ? const AuthScreen() : const MainPage()));
    });

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(99, 203, 228, 1.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo1.png',
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.3,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.2,
              child: const LoadingIndicator(
                  indicatorType: Indicator.ballRotate, /// Required, The loading type of the widget
                  colors: [Colors.white],       /// Optional, The color collections
                  strokeWidth: 4,                     /// Optional, The stroke of the line, only applicable to widget which contains line
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool signIn = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey[800],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blueGrey[700],
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SimpleTextForm(
                      validator: (val) {
                        if (val == null ||
                            val.isEmpty ||
                            val.length < 4) {
                          return 'please enter valid email';
                        } else {
                          return null;
                        }
                      },
                      label: 'Email',
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      obscure: false,
                      icon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SimpleTextForm(
                      validator: (val) {
                        if (val == null || val.isEmpty || val.length < 6) {
                          return 'please enter at least 6 characters';
                        } else {
                          return null;
                        }
                      },
                      label: 'Password',
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      obscure: true,
                      icon: const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      child: EnglishText(
                        text: signIn ? 'Sign In' : 'Sign Up',
                      ),
                      color: Colors.white24,
                      textColor: Colors.white,
                      onPressed: signIn
                          ? () async {
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const MainPage()));
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        Text('No user found for that email.'),
                                  ));
                                } else if (e.code == 'wrong-password') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        'Wrong password provided for that user.'),
                                  ));
                                }
                              }
                            }
                          : () async {
                              UserCredential userCredential;
                              try {
                                userCredential = await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                //store email in FirebaseFirestore
                                await FirebaseFirestore.instance
                                    .collection('UsersData')
                                    .doc(userCredential.user.uid)
                                    .set({'email': userCredential.user.email});
                                //navigate to home after account created
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const MainPage()));
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        'The password provided is too weak.'),
                                  ));
                                } else if (e.code == 'email-already-in-use') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        'The account already exists for that email.'),
                                  ));
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      e.toString()),
                                ));
                              }
                            },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            signIn
                                ? 'create new account?   '
                                : 'already have account?   ',
                          style: const TextStyle(fontSize: 15),
                        ),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              signIn = !signIn;
                            });
                          },
                          color: Colors.blueGrey[600],
                          child: Text(
                              signIn ? 'SignUp' : 'SignIn', style: const TextStyle(fontSize: 15),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin;

callbackDispatcher() async {
  //initialize notification every time
  flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingAndroid =
      AndroidInitializationSettings('applogo');
  const IOSInitializationSettings initializationSettingIOS =
      IOSInitializationSettings();

  const InitializationSettings initializationSetting = InitializationSettings(
    android: initializationSettingAndroid,
    iOS: initializationSettingIOS,
  );

  WidgetsFlutterBinding.ensureInitialized();

  await flutterLocalNotificationPlugin.initialize(initializationSetting);

  Workmanager().executeTask((taskName, inputData) async {
    await Firebase.initializeApp();
    User user = FirebaseAuth.instance.currentUser;
    int index = Random().nextInt(Daily().dailyData.length - 1);
    String message = Daily().dailyData[index]['message'];
    String writer = Daily().dailyData[index]['writer'];
    await FirebaseFirestore.instance
        .collection('UsersData')
        .doc(user.uid)
        .collection('New Messages')
        .doc()
        .set({
      'message': message,
      'writer': writer,
      'timestamp': DateTime.now(),
    });
    sendDailyNotification();
    Daily().dailyData.removeAt(index);
    return Future.value(true);
  });
}

sendDailyNotification() async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      const AndroidNotificationDetails('randomIndex.0', 'BooQuote',
          channelDescription: 'Your have a new message',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true);

  IOSNotificationDetails iOSPlatformChannelSpecifics =
      const IOSNotificationDetails(threadIdentifier: 'thread_id');

  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  await flutterLocalNotificationPlugin.show(
    Random().nextInt(50),
    'BooQuote',
    'you have a new message',
    platformChannelSpecifics,
  );
}
