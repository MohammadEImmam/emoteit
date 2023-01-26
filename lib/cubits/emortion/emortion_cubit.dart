import 'package:bloc/bloc.dart';
import 'package:emoteit/get/get_feed.dart';
import 'package:http/http.dart' as http;
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
      emit(ResponseEmortionState(emortionList));
    } catch (e) {
      var error = e.toString();
      emit(ErrorEmortionState("ERROR STATE : $error"));
    }
  }

  startEmortionInsight(emortionID) async{
    String url = "https://us-central1-emoteit-96e60.cloudfunctions.net/emoteit_server/api/emortion/insight/$emortionID";
    final uri = Uri.parse(url);
    final response = await http.post(uri, headers:{"access-token": token});
    if(response.statusCode == 200){
      return response.body;
    } else {
      throw Exception('Failed to start insight for emortion $emortionID STATUS CODE : ${response.statusCode}');
    }
  }
}
