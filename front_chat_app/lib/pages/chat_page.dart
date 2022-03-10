// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_chat_app/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({ Key? key }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{

  final _textCtlr = TextEditingController();
  final _focusNode = FocusNode();

  List<ChatMessage> _messages = [
    // ChatMessage(text: 'Hola', uid: '123'),
    // ChatMessage(text: 'Hola', uid: '23'),
    // ChatMessage(text: 'Hola', uid: '123'),
    // ChatMessage(text: 'Hola', uid: '12243'),
  ];

  bool _isTyping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black54
        ),
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Text('U1', style: TextStyle(fontSize: 12)),
              maxRadius: 14),
            SizedBox(width: 3),
            Text('Usuario1', style: TextStyle(color: Colors.black45, fontSize: 15),)
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
              )),
            Divider(height: 1,),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      )
    );
  }

  Widget _inputChat(){
    return SafeArea(child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8 ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textCtlr,
              onSubmitted: _handleSubmit,
              onChanged: (String texto){
                setState(() {
                  texto.trim().length > 0 ? _isTyping = true : _isTyping = false;
                });
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Escribir mensaje'),
              focusNode: _focusNode,
            )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
              ? CupertinoButton(
                child: Text('Enviar'),
                onPressed: _isTyping
                  ? () => _handleSubmit(_textCtlr.text.trim())
                  : null)
              : Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconTheme(
                  data: IconThemeData(color: Colors.blue),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(Icons.send),
                    onPressed: _isTyping
                      ? () => _handleSubmit(_textCtlr.text.trim())
                      : null),
                ),
                ),
              )
              
            
        ],
      ),
    ));
  }

  _handleSubmit(String text){
    if (text.length == 0) return;
    print(':::::::' + text);
    _textCtlr.clear();
    _focusNode.requestFocus();
    final _msg = ChatMessage(
      text: text, 
      uid: '123', 
      animationctrl: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300)),);
    _messages.insert(0, _msg);
    _msg.animationctrl.forward();
    setState(() {
      _isTyping = false;
    });
  }

  @override
  void dispose() {
    // TODO: off del socket

    for (ChatMessage message in _messages) {
      message.animationctrl.dispose();
    }
    super.dispose();
  }
}