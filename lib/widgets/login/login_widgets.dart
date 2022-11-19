import 'package:flutter/material.dart';
class UserCard{
  String name;
  String pictureURL;
  String score;
  int answerTime;
  UserCard(this.name, this.pictureURL, this.score, this.answerTime): super();
  createUserCard(name, pictureURL, score, answerTime){
    return Card(
      child:
      SizedBox(
          width: 300,
          height: 75,
          child: Row(
            children: <Widget>[
              Container(
                width: 100,
                height: 65,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: (Colors.yellow[600]!),
                    //<-- SEE HERE
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(pictureURL),
                  ),
                ),
              ),
              Text("\nName : $name\n"
                  "Score : $score\n"
                  "Average Time : ${(answerTime/ 10000).round()} seconds\n")
            ],
          )),
    );
  }
}

class Bubble{
  late Color color;
  late int count;
  late String text;
  late IconData icon;
  Bubble(this.color, this.count, this.text, this.icon);
  createBubble(count, context){
    return Expanded(
        child: Column(children: <Widget>[
          Container(
            height:
            MediaQuery.of(context).size.height *
                0.065,
            width:
            MediaQuery.of(context).size.height *
                0.065,
            decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle),
            child: Icon(icon),
          ),
          Text(
            "\n $text",
            style: TextStyle(
                color: Colors.blue[300],
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "$count",
            style: TextStyle(
                color: Colors.blue[300],
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
        ]));
  }
}

class RoundedClipper extends CustomClipper<Path> {
  var differenceInHeights = 0;

  RoundedClipper(this.differenceInHeights);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - differenceInHeights);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}