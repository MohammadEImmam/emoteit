import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/cubits/leaderboard/stats_cubit.dart';
import 'get/get_leaderboard.dart';
import 'widgets/login/login_widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'google_signup.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'emoteit',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StatsCubit>(
          create: (context) => StatsCubit(Leaderboard()),
        ),
      ],
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

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<StatsCubit>();
      cubit.fetchStats();
    });
  }

  // @override
  // void dispose() {
  //   // Clean up the focus node when the Form is disposed
  //   myFocusNode.dispose();
  //   super.dispose();
  // }

  // TODO: Set the bloc builder to the specific element rather than the whole screen
  // Entire page now loads due to the bloc builder position... fix for constant UI
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
                                    signup(context);
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
                                children:<Widget> [
                                  Bubble(Colors.blue[300]!, 0, "Emortions", Icons.emoji_emotions),
                                  Bubble(Colors.green[400]!, 0, "Insights", Icons.question_answer),
                                  Bubble(Colors.red[300]!, 0, "New Emorters", Icons.person),
                                  Bubble(Colors.yellow[800]!, 0, "Friendships", Icons.people),
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
                              child: LeaderCard(state.leaders[0].name, state.leaders[0].pictureURL, state.leaders[0].score,state.leaders[0].answerTime),
                            ),
                            Center(
                              child: LeaderCard(state.leaders[1].name, state.leaders[1].pictureURL, state.leaders[1].score,state.leaders[1].answerTime),
                            ),
                            Center(
                              child: LeaderCard(state.leaders[2].name, state.leaders[2].pictureURL, state.leaders[2].score,state.leaders[2].answerTime),
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
}
