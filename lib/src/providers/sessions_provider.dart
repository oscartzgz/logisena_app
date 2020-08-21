import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logisena/src/api.dart';

class SessionsProvider {
  final _storage = FlutterSecureStorage();
  final _url = Api.sessions;

  Future<bool> createSession(enrollment, password) async {
    final _body = {
      "employee[enrollment]": enrollment,
      "employee[password]": password
    };
    final response = await http.post(_url, body: _body);
    if (response.statusCode == 201) {
      final decodedData = json.decode(response.body);
      _saveJwt(decodedData['token']);
      _saveEnrollment(decodedData['enrollment']);
      return true;
    }
    return false;
  }

  Future<bool> destroySession() async {
    final _jwt = await _storage.read(key: 'jwt');
    final _headers = {'Authorization': _jwt};
    final response = await http.delete(_url, headers: _headers);
    // if (response.statusCode == 204 || response.statusCode == 401) {
    await _storage.delete(key: 'enrollment');
    await _storage.delete(key: 'jwt');
    return true;
    // }
    // return false;
  }

  Future<bool> tryJWTLogin() async {
    final _jwt = await _getJWT();
    final _url = Api.sessions;
    final _headers = {'Authorization': _jwt};
    final response = await http.get(_url, headers: _headers);
    if (response.statusCode == 200) return true;
    return false;
  }

  _saveJwt(String jwt) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'jwt', value: jwt);
  }

  _saveEnrollment(String enrollment) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'enrollment', value: enrollment);
  }

  Future<String> _getJWT() async {
    final String _jwt = await _storage.read(key: 'jwt');
    return _jwt;
  }
}
