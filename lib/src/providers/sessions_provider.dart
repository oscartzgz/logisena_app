import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logisena/src/providers/configuration.dart';

class SessionsProvider {
  final _storage = FlutterSecureStorage();

  Future<bool> createSession(email, password) async {
    final _url = Configurations.sessions;
    final _body = {"employee[email]": email, "employee[password]": password};
    final response = await http.post(_url, body: _body);
    if (response.statusCode == 201) {
      final decodedData = json.decode(response.body);
      _saveJwt(decodedData['token']);
      _saveEmail(decodedData['email']);
      return true;
    }
    return false;
  }

  Future<bool> tryJWTLogin() async {
    final _jwt = await _getJWT();
    final _url = Configurations.sessions;
    final _headers = {'Authorization': _jwt};
    final response = await http.get(_url, headers: _headers);
    if (response.statusCode == 200) return true;
    return false;
  }

  _saveJwt(String jwt) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'jwt', value: jwt);
  }

  _saveEmail(String email) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'email', value: email);
  }

  Future<String> _getJWT() async {
    final String _jwt = await _storage.read(key: 'jwt');
    return _jwt;
  }
}
