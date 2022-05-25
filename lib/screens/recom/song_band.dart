import 'package:final_booquote/provider/important_methods.dart';
import 'package:final_booquote/widgets/container_band.dart';
import 'package:final_booquote/widgets/english_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SongBand extends StatefulWidget {
  final String logoApp;
  final String appName;

  const SongBand({Key key, this.logoApp, this.appName}) : super(key: key);

  @override
  State<SongBand> createState() => _SongBandState();
}

class _SongBandState extends State<SongBand> {

  FToast fToast;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          children: [
            Image.asset(
              widget.logoApp,
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            EnglishText(
              text: widget.appName,
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          image: const DecorationImage(
            image: AssetImage('assets/images/app_background.png'),
            fit: BoxFit.cover
          )
        ),
        child: widget.appName == 'Soundcloud'
            ? Stack(
          children: [
            PageView(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ContainerBand(
                          bandLogo: 'assets/images/songs/cairokee.jpeg',
                          bandName: 'Cairokee',
                          appName: widget.appName,
                          color1: Colors.black45,
                          color2: Colors.black54,
                        ),
                        ContainerBand(
                          bandLogo: 'assets/images/songs/layla.jpg',
                          bandName: 'مشروع ليلي',
                          appName: widget.appName,
                          color1: Colors.red.shade200,
                          color2: Colors.red.shade300,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ContainerBand(
                          bandLogo: 'assets/images/songs/omar_khairat.jpeg',
                          bandName: 'Omar Khairat',
                          appName: widget.appName,
                          color1: Colors.grey.shade400,
                          color2: Colors.grey[350],
                        ),
                        ContainerBand(
                          bandLogo: 'assets/images/songs/beethoven.jpeg',
                          bandName: 'Beethoven',
                          appName: widget.appName,
                          color1: Colors.grey.shade400,
                          color2: Colors.grey[350],
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ContainerBand(
                          bandLogo: 'assets/images/songs/mzayg.jpeg',
                          bandName: 'مزايج',
                          appName: widget.appName,
                          color1: Colors.black45,
                          color2: Colors.black54,
                        ),
                        ContainerBand(
                          bandLogo: 'assets/images/songs/azez.jpg',
                          bandName: 'عزيز مرقة',
                          appName: widget.appName,
                          color1: Colors.black45,
                          color2: Colors.black54,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(10),
                child: SmoothPageIndicator(
                  axisDirection: Axis.horizontal,
                  controller: _pageController,
                  count: 2,
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
        ) : widget.appName == 'Anghami'
        ? Stack(
          children: [
            PageView(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ContainerBand(
                          bandLogo: 'assets/images/songs/cairokee.jpeg',
                          bandName: 'Cairokee',
                          appName: widget.appName,
                          color1: Colors.black45,
                          color2: Colors.black54,
                        ),
                        ContainerBand(
                          bandLogo: 'assets/images/songs/layla.jpg',
                          bandName: 'مشروع ليلي',
                          appName: widget.appName,
                          color1: Colors.red.shade200,
                          color2: Colors.red.shade300,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ContainerBand(
                          bandLogo: 'assets/images/songs/omar_khairat.jpeg',
                          bandName: 'Omar Khairat',
                          appName: widget.appName,
                          color1: Colors.grey.shade400,
                          color2: Colors.grey[350],
                        ),
                        ContainerBand(
                          bandLogo: 'assets/images/songs/azez.jpg',
                          bandName: 'عزيز مرقة',
                          appName: widget.appName,
                          color1: Colors.black45,
                          color2: Colors.black54,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Provider.of<ImportantMethods>(context, listen: false).themeMode == ThemeMode.dark?
                                Colors.transparent : Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                'There is one more band in Soundcloud',
                                style: TextStyle(
                                  fontFamily: 'Righteous',
                                  fontSize: 15,
                                  color: Provider.of<ImportantMethods>(context, listen: false).themeMode == ThemeMode.dark? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(10),
                child: SmoothPageIndicator(
                  axisDirection: Axis.horizontal,
                  controller: _pageController,
                  count: 2,
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
        )
        : Stack(
          children: [
            PageView(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ContainerBand(
                          bandLogo: 'assets/images/songs/cairokee.jpeg',
                          bandName: 'Cairokee',
                          appName: widget.appName,
                          color1: Colors.black45,
                          color2: Colors.black54,
                        ),
                        ContainerBand(
                          bandLogo: 'assets/images/songs/layla.jpg',
                          bandName: 'مشروع ليلي',
                          appName: widget.appName,
                          color1: Colors.red.shade200,
                          color2: Colors.red.shade300,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ContainerBand(
                          bandLogo: 'assets/images/songs/omar_khairat.jpeg',
                          bandName: 'Omar Khairat',
                          appName: widget.appName,
                          color1: Colors.grey.shade400,
                          color2: Colors.grey[350],
                        ),
                        ContainerBand(
                          bandLogo: 'assets/images/songs/beethoven.jpeg',
                          bandName: 'Beethoven',
                          appName: widget.appName,
                          color1: Colors.grey.shade400,
                          color2: Colors.grey[350],
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ContainerBand(
                          bandLogo: 'assets/images/songs/azez.jpg',
                          bandName: 'عزيز مرقة',
                          appName: widget.appName,
                          color1: Colors.black45,
                          color2: Colors.black54,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Provider.of<ImportantMethods>(context, listen: false).themeMode == ThemeMode.dark?
                                Colors.transparent : Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                'There is one more band in Soundcloud',
                                style: TextStyle(
                                  fontFamily: 'Righteous',
                                  fontSize: 15,
                                  color: Provider.of<ImportantMethods>(context, listen: false).themeMode == ThemeMode.dark? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(10),
                child: SmoothPageIndicator(
                  axisDirection: Axis.horizontal,
                  controller: _pageController,
                  count: 2,
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
