import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {

  final String label;
  final Function() onPressed;
  const BlueButton({ Key? key, required this.label, required this.onPressed }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(32)
        ),
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 18)),
        ),
      ),
      onPressed: onPressed
    );
  }
}
