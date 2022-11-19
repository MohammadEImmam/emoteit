import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/cubits/leaderboard/stats_cubit.dart';
import 'get/get_leaderboard.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatsCubit(Leaderboard()),
      child: const MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late FocusNode myFocusNode;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<StatsCubit>();
      cubit.fetchStats();
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  // TODO: Set the bloc builder to the specific element rather than the whole screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<StatsCubit, StatsState>(
          builder: (context, state) {
            if (state is InitStatsState || state is LoadingStatsState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ResponseStatsState) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        ClipPath(
                          clipper: RoundedClipper(60),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.deepPurple[300],
                          ),
                        ),
                        ClipPath(
                          clipper: RoundedClipper(50),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.33,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                        Positioned(
                            top: -110,
                            left: -110,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.30,
                              width: MediaQuery.of(context).size.height * 0.30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      (MediaQuery.of(context).size.height *
                                              0.30) /
                                          2),
                                  color:
                                      Colors.deepPurple[300]?.withOpacity(0.3)),
                              child: Center(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.deepPurpleAccent),
                                ),
                              ),
                            )),
                        Positioned(
                            top: -100,
                            left: 100,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.36,
                              width: MediaQuery.of(context).size.height * 0.36,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      (MediaQuery.of(context).size.height *
                                              0.36) /
                                          2),
                                  color:
                                      Colors.deepPurple[300]?.withOpacity(0.3)),
                              child: Center(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.deepPurpleAccent),
                                ),
                              ),
                            )),
                        Positioned(
                            top: -50,
                            left: 60,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.height * 0.15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      (MediaQuery.of(context).size.height *
                                              0.15) /
                                          2),
                                  color:
                                      Colors.deepPurple[300]?.withOpacity(0.3)),
                            )),
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.15 -
                                  50),
                          height: MediaQuery.of(context).size.height * 0.33,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                "assets/login.png",
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width:
                                    MediaQuery.of(context).size.height * 0.22,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(20, 12, 20, 10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: const <Widget>[],
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            GestureDetector(
                                onTap: () {
                                  if (kDebugMode) {
                                    print("pressed");
                                  }
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.065,
                                  decoration: const BoxDecoration(
                                      color: Colors.deepPurpleAccent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25))),
                                  child: const Center(
                                    child: Text(
                                      "Google Login",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            const Center(
                              child: Text(
                                "Total Stats :\n",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Column(children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                      child: Column(children: <Widget>[
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.065,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.065,
                                      decoration: BoxDecoration(
                                          color: Colors.blue[200],
                                          shape: BoxShape.circle),
                                      child: const Icon(Icons.emoji_emotions),
                                    ),
                                    Text(
                                      "\n Emortions",
                                      style: TextStyle(
                                          color: Colors.blue[300],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${state.stats.insightCount}",
                                      style: TextStyle(
                                          color: Colors.blue[300],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ])),
                                  Expanded(
                                      child: Column(children: <Widget>[
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.065,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.065,
                                      decoration: BoxDecoration(
                                          color: Colors.green[400],
                                          shape: BoxShape.circle),
                                      child: const Icon(Icons.question_answer),
                                    ),
                                    Text(
                                      "\n Insights",
                                      style: TextStyle(
                                          color: Colors.blue[300],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${state.stats.insightCount}",
                                      style: TextStyle(
                                          color: Colors.blue[300],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ])),
                                  Expanded(
                                      child: Column(children: <Widget>[
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.065,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.065,
                                      decoration: BoxDecoration(
                                          color: Colors.red[300],
                                          shape: BoxShape.circle),
                                      child: const Icon(Icons.person),
                                    ),
                                    Text(
                                      "\n New Emorters",
                                      style: TextStyle(
                                          color: Colors.blue[300],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${state.stats.newUserCount}",
                                      style: TextStyle(
                                          color: Colors.blue[300],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ])),
                                  Expanded(
                                      child: Column(children: <Widget>[
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.065,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.065,
                                      decoration: BoxDecoration(
                                          color: Colors.yellow[800],
                                          shape: BoxShape.circle),
                                      child: const Icon(Icons.people),
                                    ),
                                    Text(
                                      "\n Friendships",
                                      style: TextStyle(
                                          color: Colors.blue[300],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${state.stats.newRelationshipCount}",
                                      style: TextStyle(
                                          color: Colors.blue[300],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ])),
                                ],
                              ),
                            ]), // column widget ends here
                            Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 15),
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: GestureDetector(
                                  onTap: () {
                                    if (kDebugMode) {
                                      print("signup");
                                    }
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()));
                                  },
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const <Widget>[
                                        Text(
                                          "What is Emote-It",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "About?",
                                          style: TextStyle(
                                              color: Colors.deepPurpleAccent,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                            Center(
                              child: Card(
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
                                              image: NetworkImage(state
                                                  .leaders[0].pictureURL),
                                            ),
                                          ),
                                        ),
                                        Text("\nName : ${state.leaders[0].name}\n"
                                            "Score : ${state.leaders[0].score}\n"
                                            "Average Time : ${(state.leaders[0].answerTime / 10000).round()} seconds\n")
                                      ],
                                    )),
                              ),
                            ),
                            Center(
                              child: Card(
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
                                                image: NetworkImage(state
                                                    .leaders[1].pictureURL),
                                              ),
                                            ),
                                          ),
                                          Text("\nName : ${state.leaders[1].name}\n"
                                              "Score : ${state.leaders[1].score}\n"
                                              "Average Time : ${(state.leaders[1].answerTime / 10000).round()} seconds\n")
                                        ],
                                      )),
                              ),
                            ),
                            Center(
                              child: Card(
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
                                              image: NetworkImage(state
                                                  .leaders[2].pictureURL),
                                            ),
                                          ),
                                        ),
                                        Text("\nName : ${state.leaders[2].name}\n"
                                            "Score : ${state.leaders[2].score}\n"
                                            "Average Time : ${(state.leaders[2].answerTime / 10000).round()} seconds\n")
                                      ],
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else if (state is ErrorStatsState) {
              return Center(
                child: Text(state.message),
              );
            }
            return Center(child: Text(state.toString()));
          },
        ));
  }

  bool _value1 = false;

  void _value1Changed(bool value) => setState(() => _value1 = value);

  String? validatePassword(String value) {
    if (value.length < 6) {
      return 'Password must be atleast 6 digits';
    } else {
      return null;
    }
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
