import 'package:final_booquote/data/basic_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/hard_partitions.dart';
import 'package:flutter/material.dart';

import 'data_screen/basic_data_screen.dart';

class CalmDown extends StatefulWidget {
  const CalmDown({Key key}) : super(key: key);

  @override
  _CalmDownState createState() => _CalmDownState();
}

class _CalmDownState extends State<CalmDown> {
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
        tag: 'to-calmDown',
        child: Stack(
          children: [
            PageView(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              children: [
                HardPartitions(
                  'Stress',
                      () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BasicDataScreen(
                        screenTitle: 'Stress',
                        listName: BasicData.stressList,
                      ))),
                  'assets/images/stress.jpg',
                ),
                HardPartitions(
                  '',
                      () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BasicDataScreen(
                        screenTitle: 'Hope',
                        listName: BasicData.hopeList,
                      ))),
                  'assets/images/hope.jpg',
                ),
                HardPartitions(
                  'Appreciation',
                  () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BasicDataScreen(
                    screenTitle: 'Appreciation',
                    listName: BasicData.appreciationList,
                  ))),
                  'assets/images/appreciation.jpg',
                ),
                HardPartitions(
                  'Faith',
                      () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BasicDataScreen(
                        screenTitle: 'Faith',
                        listName: BasicData.faithList,
                      ))),
                  'assets/images/faith.jpg',
                ),
                HardPartitions(
                  'Be Yourself',
                      () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BasicDataScreen(
                        screenTitle: 'Be Yourself',
                        listName: BasicData.beYourselfList,
                      ))),
                  'assets/images/yourself.jpg',
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
                  count: 5,
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
