import '../provider/important_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnglishText extends StatelessWidget {
  final String text;

  const EnglishText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Righteous',
        fontSize: MediaQuery.of(context).textScaleFactor * 20,
        color: Provider.of<ImportantMethods>(context, listen: false).themeMode == ThemeMode.dark? Colors.white : Colors.black,
      ),
    );
  }
}
