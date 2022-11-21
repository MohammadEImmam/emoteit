import 'package:bloc/bloc.dart';
import 'package:emoteit/get/get_feed.dart';

import '../../models/emortion_model.dart';
part 'emortion_state.dart';

class EmortionCubit extends Cubit<EmortionState> {
  final String limit;
  final String token;
  final Feed _feed;
  EmortionCubit(this.limit, this.token, this._feed) : super(EmortionInitial());

  Future<void> fetchEmortion() async {
    emit(LoadingEmortionState());
    try {
      final emortionList = await _feed.getFeed(limit, token);
      print("Got the emortion list");
      emit(ResponseEmortionState(emortionList));
    } catch (e) {
      var error = e.toString();
      emit(ErrorEmortionState("ERROR STATE : $error"));
    }
  }
}
