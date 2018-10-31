import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {

  final title;
  final content;
  final VoidCallback callback;
  final actiontext;

  DialogBox(this.title,this.content,this.callback,[this.actiontext="Reset"]);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        FlatButton(onPressed: callback, child:Text(actiontext) ,color: Colors.white,)
      ],
    );
  }
}
