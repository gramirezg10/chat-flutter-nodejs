// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  final String route;
  final String message1; //'¿No tienes cuenta?'
  final String message2; //'Crea una ahora!'


  const Labels({
    Key? key,
    required this.route, required this.message1, required this.message2
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          Text(message1, 
          style: TextStyle(
            color: Colors.black54,
            fontSize: 15, fontWeight: FontWeight.w300)),
          SizedBox(height: 10),
          GestureDetector(
            child: Text(message2, 
            style: TextStyle(
              color: Colors.blue[600],
              fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: (){
              Navigator.pushReplacementNamed(context, route);
            },
          ),
        ],
      ),
    );
  }
}