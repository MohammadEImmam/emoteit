import 'package:emoteit/models/emoteit_user_model.dart';

class Emortion{
  final String id;
  final EmoteItUser user;
  final List<String> emojis;
  final String secret;
  final String expiresAt;
  final bool deprecated;
  final int categoryID;
  final int privacyID;
  final List<dynamic> reactionIDs;
  final List<String> insightUIDS;
  final String createdAt;
  final String updatedAt;

  const Emortion({
    required this.id,
    required this.user,
    required this.emojis,
    required this.secret,
    required this.expiresAt,
    required this.deprecated,
    required this.categoryID,
    required this.privacyID,
    required this.reactionIDs,
    required this.insightUIDS,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Emortion.fromJson(Map<String, dynamic> json) {
    return Emortion(
        id: json['_id'],
        user: EmoteItUser.fromJson(json['createdBy']),
        emojis: List<String>.from(json['message']),
        secret: json['secret'],
        expiresAt: json['expiresAt'],
        deprecated: json['deprecated'],
        categoryID: json['categoryId'],
        privacyID: json['privacyId'],
        reactionIDs: List<String>.from(json['reactionIds']),
        insightUIDS: List<String>.from(json['insightUIds']),
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }
}