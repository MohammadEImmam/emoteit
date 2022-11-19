class Stats{
  final int emortionCount;
  final int insightCount;
  final int newUserCount;
  final int newRelationshipCount;
  const Stats({
    required this.emortionCount,
    required this.insightCount,
    required this.newUserCount,
    required this.newRelationshipCount,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      emortionCount: json['emortionCount'],
      insightCount: json['insightCount'],
      newUserCount: json['newUserCount'],
      newRelationshipCount: json['newRelationshipCount'],
    );
  }
}

class Leaders{
  final String id;
  final String name;
  final int answerTime;
  final String email;
  final String time;
  final int score;
  final int typeID;
  final String pictureURL;
  final String uID;
  final String createdAt;
  final String updatedAt;

  const Leaders({
    required this.id,
    required this.name,
    required this.answerTime,
    required this.email,
    required this.time,
    required this.score,
    required this.typeID,
    required this.pictureURL,
    required this.uID,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Leaders.fromJson(Map<String, dynamic> json) {
    return Leaders(
      id: json['_id'],
      name: json['name'],
      answerTime: json['totalAnswerTimeMs'],
      email: json['email'],
      time: json['DOB'],
      score: json['score'],
      typeID: json['typeId'],
      pictureURL: json['pictureUrl'],
      uID: json['uid'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}