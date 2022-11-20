import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'gen/assets.gen.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';

class Page25 extends StatefulWidget {
  const Page25({Key? key}) : super(key: key);

  @override
  State<Page25> createState() => _Page25State();
}

class _Page25State extends State<Page25> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 39.h,
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
                          'My goals',
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.workSans().fontFamily,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'June 2021',
                              style: TextStyle(
                                fontSize: 18.sp,
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
                      child: Container(
                        height: 40.h,
                        width: 40.h,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 13.h,
              ),
              SizedBox(
                height: 80.h,
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
                            radius: 30.r,
                            backgroundColor: Colors.grey,
                            child: CircleAvatar(
                              radius: 29.r,
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
              SizedBox(
                height: 20.h,
              ),
              SizedBox(width: 20.w),
              ListView.separated(
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20.h);
                },
                itemBuilder: (context, index) {
                  return GoalCard(
                    goalNumber: index + 1,
                  );
                },
              ),
              SizedBox(width: 20.w),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 90.h,
        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xffE0E0E0))),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 54.w, right: 54.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.svg.m6.motionPhotosPause.svg(
                  height: 24.r,
                  width: 24.r,
                  fit: BoxFit.fill,
                ),
                Assets.svg.m6.castConnected.svg(
                  height: 24.r,
                  width: 24.r,
                  fit: BoxFit.fill,
                ),
                Assets.svg.m6.debug.svg(
                  height: 24.r,
                  width: 24.r,
                  fit: BoxFit.fill,
                ),
                Assets.svg.m6.contact.svg(
                  height: 24.r,
                  width: 24.r,
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

