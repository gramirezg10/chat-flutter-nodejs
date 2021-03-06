// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:front_chat_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:front_chat_app/models/user_model.dart';


import '../widgets/user_list_tile.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({ Key? key }) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final users = [
    UserModel(uid: '001', email: 'test1@test.com', username: 'Usuario1', online: true),
    UserModel(uid: '002', email: 'test2@test.com', username: 'Usuario2', online: false),
    UserModel(uid: '003', email: 'test3@test.com', username: 'Usuario3', online: true),
    UserModel(uid: '004', email: 'test4@test.com', username: 'Usuario4', online: true),
  ];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.userModel;
    bool isOnline = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(user?.username?? 'User' , style: TextStyle(color: Colors.black54),),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black54),
          onPressed: (){ 
            // TODO: Desconectar el socket
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
          ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: isOnline ? 
              Icon(Icons.check_circle_outline, color: Colors.blue) :
              Icon(Icons.error_outline, color: Colors.red),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        child: listViewUsers(),
        onRefresh: () => _loadUsers(),
        ),
    );
  }

  ListView listViewUsers() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => userListTile(users[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: users.length,
    );
  }

  _loadUsers() async{
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}