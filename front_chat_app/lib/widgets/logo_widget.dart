// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final String _imagePath = 'assets/tag-logo.png';
  final String logoText;

  const LogoWidget({Key? key, required this.logoText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Image(image: AssetImage(_imagePath)),
            SizedBox(height: 20),
            Text(logoText, style: TextStyle(fontSize: 30),)
          ],
        ),
      ),
    );
  }
}