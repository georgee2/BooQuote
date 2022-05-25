import 'package:final_booquote/provider/important_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArabicText extends StatelessWidget {
  final double size;
  final String text;
  final Alignment alignment;

  const ArabicText({Key key, this.size, this.text, this.alignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontFamily: 'ElMessiri',
        fontSize: size,
        color: Provider.of<ImportantMethods>(context, listen: false).themeMode == ThemeMode.dark? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
