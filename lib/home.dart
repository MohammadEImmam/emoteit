import 'package:emoteit/models/emoteit_user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.user}) : super(key: key);

   final EmoteItUser user;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = const Size(390, 844);
    return Scaffold(
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
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child:               Container(
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
                  return GoalCard(
                    goalNumber: index + 1,
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



class GoalCard extends StatelessWidget {
  final int goalNumber;

  const GoalCard({
    Key? key,
    required this.goalNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      // height: 100,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Goals #$goalNumber',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: GoogleFonts.workSans().fontFamily,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    height: 5,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 5,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '20% completed',
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: GoogleFonts.workSans().fontFamily,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(Icons.more_vert),
              Icon(Icons.more_vert, color: Colors.transparent),
            ],
          )
        ],
      ),
    );
  }
}