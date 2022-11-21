import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/emortion_model.dart';
import '../models/emoteit_user_model.dart';
class Feed {
  Future<List<Emortion>> getFeed(limit,token) async{
    const url = "https://us-central1-emoteit-96e60.cloudfunctions.net/emoteit_server/api/user/feed?limit=5";
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers:{"access-token": token});
    if(response.statusCode == 200){
      log(response.statusCode.toString());
      log(response.body.toString());
      final json = jsonDecode(response.body) as List;
      final result = json.map((e){
        return Emortion(
          id: e['_id'],
          user: EmoteItUser.fromJson(e['createdBy']),
          emojis: List<String>.from(e['message']),
          secret: e['secret'],
          expiresAt: e['expiresAt'],
          deprecated: e['deprecated'],
          categoryID: e['categoryId'],
          privacyID: e['privacyId'],
          reactionIDs: List<String>.from(e['reactionIds']),
          insightUIDS: List<String>.from(e['insightUIds']),
          createdAt: e['createdAt'],
          updatedAt: e['updatedAt'],
        );
      }).toList();
      return result;
    } else {
      throw Exception('Failed to retrieve feed from server STATUS CODE : ${response.statusCode}');
    }
  }
}