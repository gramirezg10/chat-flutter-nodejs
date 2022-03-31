// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:front_chat_app/pages/login_page.dart';
import 'package:front_chat_app/pages/users_page.dart';
import 'package:front_chat_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Loading...'),
          );
        } 
      ),
    );
  }

  Future checkLoginState (BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final authenticated = await authService.isLoggedIn();
    if (authenticated == true) {
      // Navigator.pushReplacementNamed(context, 'users');
      Navigator.pushReplacement(context, 
        PageRouteBuilder(
          pageBuilder: ( _, __, ___) => UsersPage(),
          transitionDuration: Duration(milliseconds: 0)
      ));
    } else {
      Navigator.pushReplacement(context, 
        PageRouteBuilder(
          pageBuilder: ( _, __, ___) => LoginPage(),
          transitionDuration: Duration(milliseconds: 0)
      ));
    }
  }
}