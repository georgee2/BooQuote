import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/cupertino.dart';
import '../provider/important_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'arabic_text.dart';

class BasicMessage extends StatefulWidget {
  final String message;
  final String writer;

  const BasicMessage({
    Key key,
    this.message, this.writer,
  }) : super(key: key);

  @override
  State<BasicMessage> createState() => _BasicMessageState();
}

class _BasicMessageState extends State<BasicMessage> {
  List<String> favMessages = [];
  List<String> favWriters = [];

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.15,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
              clipper: widget.writer.isEmpty? DiagonalRoundedEdgesMessageClipper(MessageType.SEND)
                  : LowerNipMessageClipper(MessageType.RECEIVE),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15,right: 15,),
                color: Theme.of(context).primaryColor,
                child: ArabicText(
                  size: 15,
                  text: widget.message,
                ),
              ),
            ),
            const SizedBox(height: 5,),
            if(widget.writer.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                padding: const EdgeInsets.all(8),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: ArabicText(
                    text: widget.writer,
                    size: 15,
                  ),
                ),
              ),
          ],
        ),
      ),
      actions: [
        IconSlideAction(
          icon: Icons.share,
          color: Colors.transparent,
          onTap: () {
            Share.share('#Shared_from_(BooQuote)_app\n' +
                widget.message +
                '\n' +
                widget.writer);
          },
        ),
        IconSlideAction(
          icon: Provider.of<ImportantMethods>(context, listen: true)
              .favMessage
              .contains(widget.message)
              ? Icons.favorite
              : Icons.favorite_outline,
          color: Colors.transparent,
          onTap: () {
            checkMessageExist();
          },
        ),
      ],
    );
  }

  checkMessageExist() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    List<String> messages = [];
    _pref.getStringList('messages') == null
        ? messages = []
        : messages = _pref.getStringList('messages');
    List<String> writers = [];
    _pref.getStringList('writers') == null
        ? writers = []
        : writers = _pref.getStringList('writers');
    if (messages.contains(widget.message)) {
      setState(() {
        writers.remove(widget.writer);
        messages.remove(widget.message);
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Removed from favorites'),
      ));
    } else {
      setState(() {
        favMessages.add(widget.message);
        favWriters.add(widget.writer);
        writers.addAll(favWriters);
        messages.addAll(favMessages);
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('added to favorites'),
        duration: Duration(milliseconds: 1500),
      ));
    }
    favMessages.map((e) => !messages.contains(e) ?? messages.add(e));
    favWriters.map((e) => !writers.contains(e) ?? writers.add(e));
    _pref.setStringList('messages', messages);
    _pref.setStringList('writers', writers);
    Provider.of<ImportantMethods>(context, listen: false).getFavoriteData();
  }
}



