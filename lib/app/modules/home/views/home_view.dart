import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:storychain/app/helper/all_imports.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: ColorStyle.othersWhite,
              body: Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await controller.getStories();
                      },
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w(context),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 24.h(context),
                              ),
                              for (var story in controller.stories)
                                Container(
                                  width: 380.w(context),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 24.h(context),
                                    horizontal: 24.h(context),
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorStyle.greyscale50,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CommonImage(
                                            imageUrl:
                                                "https://storage.googleapis.com/linkless-app.firebasestorage.app/users/malay111/profile.png",
                                            fit: BoxFit.cover,
                                            height: 30.h(context),
                                            width: 30.h(context),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          SizedBox(
                                            width: 10.w(context),
                                          ),
                                          SizedBox(
                                            height: 30.h(context),
                                            child: Center(
                                              child: AppText(
                                                text: "Malay Patel",
                                                style:
                                                    Styles.bodyMediumSemibold(
                                                  color:
                                                      ColorStyle.greyscale500,
                                                ),
                                                minFontSize: 14
                                                    .t(context)
                                                    .toInt()
                                                    .toDouble(),
                                                // height: 30.h(context),
                                                width: 130.w(context),
                                                // centered: true,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 24.w(context),
                                          ),
                                          Spacer(),
                                          CommonButton(
                                            width: 73.w(context),
                                            height: 30.h(context),
                                            enabled: false,
                                            text: AppStrings.follow,
                                            backgroundColor:
                                                ColorStyle.primary500,
                                            onTap: () => null,
                                          ),
                                          SizedBox(
                                            width: 10.w(context),
                                          ),
                                          Icon(
                                            Icons.more_vert,
                                            color: ColorStyle.greyscale900,
                                            size: 30.t(context),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16.h(context),
                                      ),
                                      Container(
                                        width: 332.w(context),
                                        height: 1,
                                        color: ColorStyle.greyscale200,
                                      ),
                                      SizedBox(
                                        height: 16.h(context),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 240.w(context),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                AppText(
                                                  text: getKey(
                                                      story, ["title"], ""),
                                                  maxLines: null,
                                                  style: Styles.bodyLargeBold(
                                                    color:
                                                        ColorStyle.greyscale900,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.h(context),
                                                ),
                                                AppText(
                                                  text:
                                                      "Story description lmaooo this is a text that I am writting to test how does the card show when the text is tooo big so lets check haha hehe",
                                                  maxLines: null,
                                                  style:
                                                      Styles.bodyMediumSemibold(
                                                    color:
                                                        ColorStyle.greyscale700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              AppText(
                                                text: "Sentences",
                                                style: Styles.bodyMediumRegular(
                                                  color:
                                                      ColorStyle.greyscale900,
                                                ),
                                              ),
                                              AppText(
                                                text: "3/${getKey(story, [
                                                      "max_sentence"
                                                    ], 0)}",
                                                style: Styles.h2Bold(
                                                  color: ColorStyle.primary500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 24.h(context),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: 110.w(context),
                                            child: Column(
                                              children: [
                                                AppText(
                                                  text: AppStrings.contributors,
                                                  style:
                                                      Styles.bodyMediumRegular(
                                                    color:
                                                        ColorStyle.greyscale900,
                                                  ),
                                                ),
                                                AppText(
                                                  text: "4",
                                                  style: Styles.h3Bold(
                                                    color:
                                                        ColorStyle.othersPurple,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 60.h(context),
                                            width: 1,
                                            color: ColorStyle.greyscale200,
                                          ),
                                          SizedBox(
                                            width: 110.w(context),
                                            child: Column(
                                              children: [
                                                AppText(
                                                  text: AppStrings.liveNow,
                                                  style:
                                                      Styles.bodyMediumRegular(
                                                    color:
                                                        ColorStyle.greyscale900,
                                                  ),
                                                ),
                                                AppText(
                                                  text: "5",
                                                  style: Styles.h3Bold(
                                                    color:
                                                        ColorStyle.greyscale900,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 60.h(context),
                                            width: 1,
                                            color: ColorStyle.greyscale200,
                                          ),
                                          SizedBox(
                                            width: 110.w(context),
                                            child: Column(
                                              children: [
                                                AppText(
                                                  text: AppStrings.liveLimit,
                                                  style:
                                                      Styles.bodyMediumRegular(
                                                    color:
                                                        ColorStyle.greyscale900,
                                                  ),
                                                ),
                                                AppText(
                                                  text: "${getKey(story, [
                                                        "max_live"
                                                      ], 0)}",
                                                  style: Styles.h3Bold(
                                                    color:
                                                        ColorStyle.secondary500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 24.h(context),
                                      ),
                                      CommonButton(
                                        text: AppStrings.contribute,
                                        onTap: () => null,
                                        width: 332.w(context),
                                        height: 58.h(context),
                                      ),
                                      SizedBox(
                                        height: 32.h(context),
                                      ),
                                      Row(
                                        children: [
                                          AppText(
                                            text: "13th July 2021",
                                            style: Styles.bodySmallSemibold(
                                                color: ColorStyle.greyscale500),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.favorite_border,
                                            size: 24.h(context),
                                            color: ColorStyle.greyscale900,
                                          ),
                                          SizedBox(
                                            width: 8.w(context),
                                          ),
                                          AppText(
                                            text: "1,230",
                                            style: Styles.bodySmallSemibold(
                                                color: ColorStyle.greyscale900),
                                          ),
                                          SizedBox(
                                            width: 24.w(context),
                                          ),
                                          Icon(
                                            Icons.mode_comment_outlined,
                                            size: 24.h(context),
                                            color: ColorStyle.greyscale900,
                                          ),
                                          SizedBox(
                                            width: 8.w(context),
                                          ),
                                          AppText(
                                            text: "12",
                                            style: Styles.bodySmallSemibold(
                                                color: ColorStyle.greyscale900),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  CommonBottomBar(
                    selectedTab: AppStrings.home,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
