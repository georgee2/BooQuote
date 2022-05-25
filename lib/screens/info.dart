import 'package:url_launcher/url_launcher.dart';

import '../widgets/info_container.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              InfoContainer(
                name: 'George Mounir',
                description: '(App Developer)',
                imagePath: 'assets/images/george.jpg',
                email: () => _launchURL('https://www.facebook.com/george.mounir.313'),
              ),
              const SizedBox(height: 20),
              InfoContainer(
                name: 'Medrona Raed',
                description: '(Writer)',
                imagePath: 'assets/images/medrona.jpeg',
                email: () => _launchURL('https://www.facebook.com/medo.raed.9'),
              ),
              const SizedBox(height: 20),
              InfoContainer(
                name: 'Tawfik Amgad',
                description: '(App Idea, data)',
                imagePath: 'assets/images/tawfik.jpg',
                email: () => _launchURL('https://www.facebook.com/tawfik.amgad.9'),
              ),
              const SizedBox(height: 20),
              InfoContainer(
                name: 'Manar Korashy',
                description: '(Writer)',
                imagePath: 'assets/images/manar.jpeg',
                email: () => _launchURL('https://www.facebook.com/profile.php?id=100007667388826'),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch this link';
  }
}

