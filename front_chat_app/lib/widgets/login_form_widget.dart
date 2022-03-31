// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:front_chat_app/helpers/show_alert.dart';
import 'package:front_chat_app/services/auth_service.dart';
import 'package:front_chat_app/widgets/blue_button.dart';
import 'package:front_chat_app/widgets/custom_input.dart';
import 'package:provider/provider.dart';

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
    final authService = Provider.of<AuthService>(context);
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
            onPressed: authService.autenticando ? () => {} : () async {
              FocusScope.of(context).unfocus();
              if (widget.registerForm) {
                final registerOk = await authService.register(nameCtrl.text.trim(), emailCtrl.text.trim(), passCtrl.text.trim());
                if (registerOk == true) {
                  Navigator.pushReplacementNamed(context, 'users');
                } else {
                  ShowAlert(context, 'Registro incorrecto', registerOk);
                }
              } else {
                final loginOk = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());
                if (loginOk) {
                  Navigator.pushReplacementNamed(context, 'users');
                } else {
                  ShowAlert(context, 'Login incorrecto', 'Credenciales incorrectas');
                }
              }
            },
          )
        ],
      ),
    );
  }
}