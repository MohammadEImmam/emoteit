import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/emoteit_user_model.dart';


  Future<EmoteItUser> getUser(String token) async {
    const url = "https://us-central1-emoteit-96e60.cloudfunctions.net/emoteit_server/api/user/authenticate";
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers:{"access-token": token});
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return EmoteItUser.fromJson(json);
    } else {
      throw Exception('Failed to retrieve user from server STATUS CODE : ${response.statusCode} ${response.body}');
    }
  }