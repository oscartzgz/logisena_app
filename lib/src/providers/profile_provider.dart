import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert' show json;
import 'package:http/http.dart' as http;
import 'package:logisena/src/api.dart';
import 'package:logisena/src/models/profile_model.dart';

class ProfileProvider {
  final storage = FlutterSecureStorage();

  ProfileProvider();

  Future<ProfileModel> getProfile() async {
    final jwt = await storage.read(key: 'jwt');
    final Map<String, String> headers = {"Authorization": jwt};
    final response = await http.get(Uri.parse(Api.profile), headers: headers);
    if (response.statusCode == 200) {
      final decodedData =
          ProfileModel.fromJson(json.decode(response.body)['data']);
      return decodedData;
    } else {
      return null;
    }
  }
}
