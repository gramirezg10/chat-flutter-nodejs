// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

ShowAlert (BuildContext context, String title, String subtitle){
  
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () => Navigator.pop(context),
            )
        ],
      ));
  } 
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(subtitle),
      actions: <Widget>[
        MaterialButton(
          child: Text('Ok'),
          elevation: 5,
          textColor: Colors.blue,
          onPressed: () => Navigator.pop(context)
        )
      ],
    ));
  
}