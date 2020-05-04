import 'package:flutter/material.dart';

class LogInButton extends StatefulWidget {
  Function callback;
  LogInButton(this.callback);
  @override
  _LogInButtonState createState() => _LogInButtonState();
}

class _LogInButtonState extends State<LogInButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      padding: EdgeInsets.all(5),
      onPressed: widget.callback,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.yellow, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      label: Text('Sign in', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
      icon: Icon(Icons.email, color:Colors.white, size: 30,),
      textColor: Colors.white,
      color: Colors.blue[900],);
  }
}
