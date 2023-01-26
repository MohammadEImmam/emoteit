import 'package:flutter_emoji/flutter_emoji.dart';

class EmojiController{
  String parseEmoji(List<String> inputEmojiList){
    var parser = EmojiParser();
    var emojiList = inputEmojiList;
    List<Emoji> emojis = [];
    for(var i = 0; i < emojiList.length; i++){
      emojis.add(parser.get(emojiList[i]));
    }
    String emojiString = "";
    for(var i = 0; i < emojis.length; i++){
      emojiString += emojis[i].code;
    }
    return emojiString;
  }
}