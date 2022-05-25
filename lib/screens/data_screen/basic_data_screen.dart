import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../widgets/basic_message.dart';
import '../../widgets/english_text.dart';
import 'package:flutter/material.dart';

class BasicDataScreen extends StatelessWidget {
  final String screenTitle;
  final List<Map> listName;

  const BasicDataScreen({Key key, this.screenTitle, this.listName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;

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
        title: EnglishText(
          text: screenTitle,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          image: const DecorationImage(
            image: AssetImage("assets/images/app_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: AnimationLimiter(
          child: ListView.builder(
            padding: EdgeInsets.all(_w / 30),
            physics:
            const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: listName.length,
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
                        message: listName[i]['message'],
                        writer: listName[i]['writer'],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}