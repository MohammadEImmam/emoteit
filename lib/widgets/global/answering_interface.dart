import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/emortion_model.dart';

class AnsweringInterface extends StatelessWidget{
  final Emortion emortion;
  final String emojiString;
  const AnsweringInterface(this.emortion, this.emojiString, {super.key});
  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: Text("${emortion.user.name}'s Emortion"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(emojiString),
      TextFormField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Guess the Emortion!',
        ),
        )
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Quit'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Answer'),
        ),
      ],
    );
  }
}