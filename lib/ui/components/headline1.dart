import 'package:flutter/material.dart';

class Headline1 extends StatelessWidget {
  final String text;

  // ignore: use_key_in_widget_constructors
  const Headline1({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
