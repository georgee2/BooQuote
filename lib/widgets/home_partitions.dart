import 'package:flutter/material.dart';

import 'english_text.dart';

class HomePartitions extends StatelessWidget {

  final String partitionName;
  final Function() onPress;

  const HomePartitions(this.partitionName, this.onPress, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(-1, 5),
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPress,
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: EnglishText(
            text: partitionName,
          ),
        ),
      ),
    );
  }
}
