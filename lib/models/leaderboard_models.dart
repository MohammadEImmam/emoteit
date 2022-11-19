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