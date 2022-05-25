import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_booquote/widgets/basic_message.dart';
import 'package:final_booquote/widgets/english_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class DailyMessage extends StatelessWidget {
  const DailyMessage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    User user = FirebaseAuth.instance.currentUser;
    final Stream<QuerySnapshot> users = FirebaseFirestore.instance.collection('UsersData').doc(user?.uid).collection('New Messages').orderBy('timestamp', descending: true).snapshots();

    return Container(
      color: Colors.transparent,
      child: StreamBuilder<QuerySnapshot>(
        stream: users,
        builder: (ctx, snapshot) {
          if(snapshot.hasError){
            return const Center(child: EnglishText(text: 'something went wrong'));
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.requireData.docs.isEmpty){
            return const Center(child: EnglishText(text: 'you will receive messages soon'));
          }
          final data = snapshot.requireData;
          return AnimationLimiter(
            child: ListView.builder(
              padding: EdgeInsets.all(_w / 30),
              physics:
              const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: data.docs.length,
              itemBuilder: (BuildContext c, int i) {
                return AnimationConfiguration.staggeredList(
                  position: i,
                  delay: const Duration(milliseconds: 100),
                  child: SlideAnimation(
                    duration: const Duration(milliseconds: 2500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    horizontalOffset: 30,
                    verticalOffset: 300.0,
                    child: FlipAnimation(
                      duration: const Duration(milliseconds: 3000),
                      curve: Curves.fastLinearToSlowEaseIn,
                      flipAxis: FlipAxis.y,
                      child: Container(
                        margin: EdgeInsets.only(bottom: _w / 20),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: BasicMessage(
                          message: '${data.docs[i]['message']}',
                          writer: '${data.docs[i]['writer']}',
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}


// ListView.builder(
// itemCount: data.size,
// itemBuilder: (context2, index) {
// return BasicMessage(
// message: '${data.docs[index]['message']}',
// writer: '${data.docs[index]['writer']}',
// );
// },
// )