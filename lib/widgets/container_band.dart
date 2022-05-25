import 'package:final_booquote/screens/recom/songs_links.dart';
import 'package:final_booquote/widgets/arabic_text.dart';
import 'package:flutter/material.dart';

class ContainerBand extends StatelessWidget {
  final String bandLogo;
  final String bandName;
  final String appName;
  final Color color1;
  final Color color2;

  const ContainerBand({Key key, this.bandLogo, this.bandName, this.appName, this.color1, this.color2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SongsLinks(appType: appName, bandName: bandName, bandLogo: bandLogo,))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 5, bottom: 5, top: 3, left: 3),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              //color: Colors.black26,
              color: color1,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.24,
            child: Container(
              padding: const EdgeInsets.only(right: 5, bottom: 5, top: 3, left: 3),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                //color: Colors.black38,
                color: color2,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              width: MediaQuery.of(context).size.height * 0.22,
              height: MediaQuery.of(context).size.height * 0.22,
              child: Container(
                padding: const EdgeInsets.only(right: 5, bottom: 5, top: 3, left: 3),
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage(bandLogo),
                      fit: BoxFit.cover,
                    )
                ),
                width: MediaQuery.of(context).size.height * 0.2,
                height: MediaQuery.of(context).size.height * 0.2,
              ),
            ),
          ),
          const SizedBox(height: 10,),
          ArabicText(text: bandName, size: 25,),
        ],
      ),
    );
  }
}
