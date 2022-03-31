import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:front_chat_app/global/environment.dart';
import 'package:front_chat_app/models/login_response.dart';
import 'package:front_chat_app/models/user_model.dart';
class AuthService with ChangeNotifier {
  UserModel? userModel;
  bool _autenticando = false;

  final _storage = FlutterSecureStorage();

  // Get y set del token
  static Future<String?> getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }
  static Future<void> deleteToken() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  bool get autenticando => _autenticando;
  set autenticando(bool valor){
    _autenticando = valor;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;
    final data = {
      'email': email,
      'password': password
    };
    final url = Uri.parse('${Environment.apiUrl}/login');
    final response = await http.post(url, 
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'}
    );
    autenticando = false;
    if (response.statusCode ==200) {
      final loginResponse = loginResponseFromJson(response.body);
      userModel = loginResponse.user;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String name, String email, String password) async {
    autenticando = true;
    final data = {
      'username': name,
      'email': email,
      'password': password
    };
    final url = Uri.parse('${Environment.apiUrl}/login/new');
    final response = await http.post(url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'}
    );
    autenticando = false;
    if (response.statusCode ==200) {
      final registerResponse = loginResponseFromJson(response.body);
      userModel = registerResponse.user;
      await _saveToken(registerResponse.token);
      return true;
    } else {
      final responseBody = jsonDecode(response.body);
      return responseBody['msg'];
    }
  }

  Future<bool?> isLoggedIn () async {
    final token = await _storage.read(key: 'token');
    // 
    final url = Uri.parse('${Environment.apiUrl}/login/renew');
    final response = await http.get(url,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token.toString()
      }
    );
    if (response.statusCode ==200) {
      final registerResponse = loginResponseFromJson(response.body);
      userModel = registerResponse.user;
      await _saveToken(registerResponse.token);
      return true;
    } else {
      _deleteToken();
      return false;
    }
    // 
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future _deleteToken() async {
    await _storage.delete(key: 'token');
  }
}