part of 'stats_cubit.dart';

abstract class StatsState{}

class InitStatsState extends StatsState{}

class LoadingStatsState extends StatsState{}

class ErrorStatsState extends StatsState{
  final String message;
  ErrorStatsState(this.message);
}

class ResponseStatsState extends StatsState{
  final Stats stats;
  final List<Leaders> leaders;
  ResponseStatsState(this.stats, this.leaders);
}
