import 'package:flutter/material.dart';

class BookPartitions extends StatelessWidget {

  final Function navigate;
  final String partitionName;
  final String imagePath;

  const BookPartitions(this.partitionName, this.navigate, this.imagePath, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigate(),
      child: Container(
        child: Center(
          child: Text(
            partitionName,
            style: const TextStyle(
              fontFamily: 'ElMessiri',
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
