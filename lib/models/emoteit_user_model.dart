class EmoteItUser{
  final String id;
  final String name;
  final int totalAnswerTimeMs;
  final String email;
  final String dOB;
  final int score;
  final int typeId;
  final String pictureUrl;
  final String uid;
  final String createdAt;
  final String updatedAt;
  const EmoteItUser({
    required this.id,
    required this.name,
    required this.totalAnswerTimeMs,
    required this.email,
    required this.dOB,
    required this.score,
    required this.typeId,
    required this.pictureUrl,
    required this.uid,
    required this.createdAt,
    required this.updatedAt,
  });
  factory EmoteItUser.fromJson(Map<String, dynamic> json) {
    return EmoteItUser(
      id: json['_id'],
      name: json['name'],
      totalAnswerTimeMs: json['totalAnswerTimeMs'],
      email: json['email'],
      dOB: json['DOB'],
      score: json['score'],
      typeId: json['typeId'],
      pictureUrl: json['pictureUrl'],
      uid: json['uid'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}