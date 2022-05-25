import 'package:final_booquote/provider/important_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'english_text.dart';

class InfoContainer extends StatelessWidget {

  final String name;
  final String description;
  final String imagePath;
  final Function email;

  const InfoContainer({Key key, this.name, this.description, this.imagePath, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Stack(
        children: [
          Positioned(
            bottom: 0.0,
            child: Container(
              padding: const EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height * 0.22,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      EnglishText(
                        text: name,
                      ),
                      const SizedBox(width: 10,),
                      Text(
                        description,
                        style: TextStyle(
                          fontFamily: 'Righteous',
                          fontSize: 15,
                          color: Provider.of<ImportantMethods>(context, listen: false).themeMode == ThemeMode.dark? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: email,
                    child: Text(
                      "contact via email",
                      style: TextStyle(
                        fontFamily: 'Righteous',
                        fontSize: 15,
                        color: Provider.of<ImportantMethods>(context, listen: false).themeMode == ThemeMode.dark? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            left: MediaQuery.of(context).size.width * 0.35,
            child: CircleAvatar(
              backgroundImage:
              AssetImage(imagePath),
              maxRadius: 50,
              minRadius: 20,
            ),
          ),
        ],
      ),
    );
  }
}
