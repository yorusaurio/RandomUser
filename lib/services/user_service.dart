import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:randomuser/models/user.dart';

class UserService {
  final baseUrl = "https://randomuser.me/api/";

  Future<List<User>> getUsers(int results) async {
    http.Response response =
    await http.get(Uri.parse("$baseUrl?results=$results"));

    if (response.statusCode == HttpStatus.ok) {
      List maps = json.decode(response.body)['results'];
      return maps.map((map) => User.fromJson(map)).toList();
    }
    return [];
  }
}