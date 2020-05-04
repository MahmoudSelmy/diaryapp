import 'package:diary_app/main.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  String tokenId;
  Home(this.tokenId);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.tokenId),
    );
  }
}
