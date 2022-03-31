// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../models/user_model.dart';

ListTile userListTile(UserModel user) {
    return ListTile(
        title: Text(user.username),
        subtitle: Text(user.email, style: TextStyle(fontSize: 12),),
        leading: CircleAvatar(
          child: Text(
            user.username.substring(0,1) + (user.username.substring(user.username.length - 1)),
            style: TextStyle(
              color: Colors.white
            ),),
          backgroundColor: Colors.blue[400],
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: user.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(10)
          ),
        ),
      );
  }