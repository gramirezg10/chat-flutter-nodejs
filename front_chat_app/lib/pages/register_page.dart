// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:front_chat_app/widgets/labels_login.dart';
import 'package:front_chat_app/widgets/login_form_widget.dart';
import 'package:front_chat_app/widgets/logo_widget.dart';

class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                LogoWidget(logoText: 'Sign up',),
                FormLogin(registerForm: true,),
                Labels(
                  message1: 'Ya tienes una cuenta?',
                  message2: 'Ingresa ahora!',
                  route: 'login',),
                Text('Términos y condiciones de uso',
                  style: TextStyle( fontWeight: FontWeight.w300),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

