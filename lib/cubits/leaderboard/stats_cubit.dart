import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../get/get_leaderboard.dart';
import '../../models/leaderboard_models.dart';
part 'stats_state.dart';

class StatsCubit extends Cubit<StatsState>{
  final Leaderboard _leaderboard;
  StatsCubit(this._leaderboard): super(InitStatsState());

  Future<void> fetchStats() async {
    emit(LoadingStatsState());
    try{
      final stats = await _leaderboard.getStats();
      final leaders = await _leaderboard.getLeaders();
      emit(ResponseStatsState(stats, leaders));
    }catch(e){
      emit(ErrorStatsState(e.toString()));
    }
  }
}
