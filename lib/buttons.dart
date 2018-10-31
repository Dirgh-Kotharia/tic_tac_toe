import 'package:flutter/material.dart';

class GameButton{
  final id;
  String text;
  Color bg;
  bool enabled;

  GameButton({this.id,this.text="",bg = Colors.blue,this.enabled=true});
}