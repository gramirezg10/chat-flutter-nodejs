// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({ Key? key, required this.text, required this.uid, required this.animationctrl }) : super(key: key);

  final String text;
  final String uid;
  final AnimationController animationctrl;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationctrl,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationctrl, curve: Curves.easeOut),
        child: Container(
          child: this.uid == '123'
          ? _myMessage()
          : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 5, left: 50, right: 5),
        child: Text(text, style: TextStyle(color: Colors.white),),
        decoration: BoxDecoration(
          color: Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }
  
  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 5, left: 5, right: 50),
        child: Text(text, style: TextStyle(color: Colors.black87),),
        decoration: BoxDecoration(
          color: Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }
}