// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:front_chat_app/widgets/blue_button.dart';
import 'package:front_chat_app/widgets/custom_input.dart';

class FormLogin extends StatefulWidget {
  final bool registerForm;
  
  const FormLogin({ Key? key, this.registerForm = false }) : super(key: key);

  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          widget.registerForm ? CustomInput(
            icon: Icons.perm_identity,
            placeHolder: 'Name',
            textController: nameCtrl,
            keyboardType: TextInputType.text,
          ) : SizedBox(),
          CustomInput(
            icon: Icons.mail_outline,
            placeHolder: 'Email',
            textController: emailCtrl,
            keyboardType: TextInputType.emailAddress,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeHolder: 'Password',
            textController: passCtrl,
            isPassword: true,
          ),
          BlueButton(
            label: 'Button',
            onPressed: (){
              print(emailCtrl.text);
            },
          )
        ],
      ),
    );
  }
}