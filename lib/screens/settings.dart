// import '../provider/important_methods.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
//
// import '../main.dart';
// import '../widgets/english_text.dart';
// import 'package:flutter/material.dart';
//
// class Settings extends StatefulWidget {
//   const Settings({Key key}) : super(key: key);
//
//   @override
//   State<Settings> createState() => _SettingsState();
// }
//
// class _SettingsState extends State<Settings> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Provider.of<ImportantMethods>(context, listen: false).downColor,
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const EnglishText(
//                   size: 20,
//                   text: 'Dark mode',
//                 ),
//                 Switch(
//                   activeColor: Colors.blue,
//                   activeTrackColor: Colors.black38,
//                   inactiveTrackColor: Colors.grey,
//                   inactiveThumbColor: Colors.blue,
//                   // value: Provider.of<ImportantMethods>(context, listen: true).darkMode == null
//                   //     ? true
//                   //     : Provider.of<ImportantMethods>(context, listen: false).darkMode,
//                   value: Provider.of<ImportantMethods>(context, listen: true).darkMode,
//                   onChanged: (bool value) {
//                     setState(() {
//                       //Provider.of<ImportantMethods>(context, listen: false).darkMode = value;
//                       Provider.of<ImportantMethods>(context, listen: false).setDarkValue(value);
//                       Provider.of<ImportantMethods>(context, listen: true).setAppTheme();
//                     });
//                   },
//                 ),
//
//               ],
//             ),
//             const SizedBox(
//               height: 25,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GestureDetector(
//                   child: const EnglishText(
//                     size: 20,
//                     text: 'Logout',
//                   ),
//                   onTap: () async{
//                     await FirebaseAuth.instance.signOut();
//                     Navigator.pushReplacement(context,
//                         MaterialPageRoute(builder: (_) => const AuthScreen()));
//                   },
//                 ),
//                 GestureDetector(
//                   child: Icon(Icons.logout, color: Provider.of<ImportantMethods>(context, listen: false).iconColor,),
//                   onTap: () async{
//                     await FirebaseAuth.instance.signOut();
//                     Navigator.pushReplacement(context,
//                         MaterialPageRoute(builder: (_) => const AuthScreen()));
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
