part of 'stats_cubit.dart';

abstract class StatsState{}

class InitStatsState extends StatsState{}

class LoadingStatsState extends StatsState{}

class ErrorTodoState extends StatsState{
  final String message;
  ErrorTodoState(this.message);
}

class ResponseStatsState extends StatsState{
  final Stats stats;
  ResponseStatsState(this.stats);
}
