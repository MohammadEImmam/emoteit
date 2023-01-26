import 'package:emoteit/cubits/emortion/emortion_cubit.dart';
import 'package:emoteit/models/emoteit_user_model.dart';
import 'package:emoteit/widgets/global/answering_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'get/emoji_controller.dart';
import 'models/emortion_model.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.user}) : super(key: key);

  final EmoteItUser user;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<EmortionCubit>();
      cubit.fetchEmortion();
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = const Size(390, 844);
    return
      Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 39,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.user.name,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.workSans().fontFamily,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Score: ${widget.user.score.toString()}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: GoogleFonts.workSans().fontFamily,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(CupertinoIcons.chevron_down),
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                ),
                                onPressed: () {
                                  final cubit = context.read<EmortionCubit>();
                                  cubit.fetchEmortion();
                                  reassemble();
                                },
                                child: const Text('Refresh'),
                              )
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child:Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: (Colors.black),
                              //<-- SEE HERE
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(widget.user.pictureUrl),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                SizedBox(
                  height: 80,
                  width: size.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 20),
                        ListView.separated(
                          itemCount: 10,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 10);
                          },
                          itemBuilder: (context, index) {
                            return CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey,
                              child: CircleAvatar(
                                radius: 29,
                                backgroundColor: Colors.white,
                                child: Center(
                                  child: Text(
                                    '${index + 20}',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(width: 20),
                ListView.separated(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 20);
                  },
                  itemBuilder: (context, index) {
                    return
                      BlocBuilder<EmortionCubit, EmortionState>(
                          builder:(context,state) {
                            if (state is EmortionInitial || state is LoadingEmortionState) {
                              return const Center(
                                child: CircularProgressIndicator(),);
                            } else if (state is ResponseEmortionState) {
                              return EmortionCard(
                                // user: widget.user,
                                emortion: state.emortion[index],
                              );
                            } else if (state is ErrorEmortionState) {
                              return Center(child: Text(state.message),);
                            }
                            return Center(child: Text(state.toString()));
                          }
                      );
                  },
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 90,
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xffE0E0E0))),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 54, right: 54),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Assets.svg.m6.motionPhotosPause.svg(
                    height: 24,
                    width: 24,
                    fit: BoxFit.fill,
                  ),
                  Assets.svg.m6.castConnected.svg(
                    height: 24,
                    width: 24,
                    fit: BoxFit.fill,
                  ),
                  Assets.svg.m6.debug.svg(
                    height: 24,
                    width: 24,
                    fit: BoxFit.fill,
                  ),
                  Assets.svg.m6.contact.svg(
                    height: 24,
                    width: 24,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}



class EmortionCard extends StatelessWidget {
  final Emortion emortion;
  // final EmoteItUser user;
  const EmortionCard({
    Key? key, required this.emortion,
    // required this.emortion, required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Weird coding style here maybe change this
    final now = DateTime.now().toUtc();
    final expirationDate = DateTime.parse(emortion.expiresAt);
    final days = now.difference(DateTime.parse(emortion.createdAt)).inDays;
    final hours = now.difference(DateTime.parse(emortion.createdAt)).inHours;
    final mins = now.difference(DateTime.parse(emortion.createdAt)).inMinutes;
    final secs = now.difference(DateTime.parse(emortion.createdAt)).inSeconds;

    final eDays = expirationDate.difference(now).inDays;
    final eHours = expirationDate.difference(now).inHours;
    final eMins = expirationDate.difference(now).inMinutes;
    final eSecs = expirationDate.difference(now).inSeconds;
    var self = "";
    bool rev = true;
    var expire = eDays > 0 ? "$eDays d left" : eHours > 0 ? "$eHours h left" : eMins > 0 ? "$eMins m left" : "$eSecs s left";
    final ago = days > 0 ? "$days d ago" : hours > 0 ? "$hours h ago" : mins > 0 ? "$mins m ago" : "$secs secs ago";
    if(now.isAfter(expirationDate)) {
      expire = "Expired";
    }
    if(emortion.secret == ""){
      rev = false;
    }
    EmojiController emojiParser = EmojiController();
    final displayEmoji = emojiParser.parseEmoji(emortion.emojis);
    return Container(
      width: 100,
      height: 300,
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Wrap(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    width:60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.circular(100), //<-- SEE HERE
                    ),
                    child: CircleAvatar(
                      radius: 48, // Image radius
                      backgroundImage: NetworkImage(emortion.user.pictureUrl),
                    )
                ),
                Column(
                  children: [
                    Text(emortion.user.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(self,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(" Category: ${emortion.categoryID}\n Posted: $ago \n Time Left: $expire", // Translate this!
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ]
          ),
          Row(
            // Need to figure out a better way to do line breaks
            children: [
              rev? const Text("\n \n") : const Text("\n"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(displayEmoji,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            // Need to figure out a better way to do line breaks
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(rev?"Insight: ${emortion.secret}":"Insight: ________________",
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const Text("\n")
            ],
          ),
          Row(
            // Need to figure out a better way to do line breaks
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //show empty widget
              rev?const Text(""):
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () {
                  // Call the answering interface here
                  var secret = context.read<EmortionCubit>().startEmortionInsight(emortion.id);
                  var interface = AnsweringInterface(emortion, displayEmoji);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => interface.build(context),
                  );
                },
                // Add a are you sure here?
                child: const Text('Answer'),
              )

            ],
          ),
          Row(
            // Need to figure out a better way to do line breaks
            children: const [
              Text("\n \n")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(
                Icons.favorite,
              ),
              Icon(
                Icons.emoji_emotions,
              ),
              Icon(
                Icons.comment,
              ),
            ],
          ),
        ],),
    );
  }
}