import 'package:final_booquote/data/basic_data.dart';
import 'package:final_booquote/screens/data_screen/basic_data_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/hard_partitions.dart';
import 'package:flutter/material.dart';

class HardTime extends StatefulWidget {
  const HardTime({Key key}) : super(key: key);

  @override
  _HardTimeState createState() => _HardTimeState();
}

class _HardTimeState extends State<HardTime> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'to-hardTime',
        child: Stack(
          children: [
            PageView(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              children: [
                HardPartitions(
                  'Loneliness',
                  () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BasicDataScreen(
                    screenTitle: 'Loneliness',
                    listName: BasicData.lonelinessList,
                  ),),),
                  'assets/images/loneliness.jpeg',
                ),
                HardPartitions(
                  'Depression',
                  () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BasicDataScreen(
                    screenTitle: 'Depression',
                    listName: BasicData.depressionList,
                  ))),
                  'assets/images/depression.jpg',
                ),
                HardPartitions(
                  'Pain',
                  () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BasicDataScreen(
                    screenTitle: 'Pain',
                    listName: BasicData.painList,
                  ))),
                  'assets/images/pain.jpeg',
                ),
                HardPartitions(
                  'Sadness',
                  () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BasicDataScreen(
                    screenTitle: 'Sadness',
                    listName: BasicData.sadnessList,
                  ))),
                  'assets/images/sadness.jpg',
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(10),
                child: SmoothPageIndicator(
                  axisDirection: Axis.vertical,
                  controller: _pageController,
                  count: 4,
                  effect: const WormEffect(),
                  onDotClicked: (index) => _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInCubic,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
