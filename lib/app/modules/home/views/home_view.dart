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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonImage(
                                      imageUrl: AppImages.logo,
                                      fit: BoxFit.cover,
                                      height: 50.h(context),
                                      width: 50.h(context),
                                      borderRadius: BorderRadius.circular(100),
                                      type: "asset",
                                    ),
                                    SizedBox(
                                      width: 10.w(context),
                                    ),
                                    AppText(
                                      text: AppStrings.appName,
                                      height: 50.h(context),
                                      style: Styles.h2Bold(
                                        color: ColorStyle.primary500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 24.h(context),
                                ),
                                for (var story in controller.stories)
                                  CommonPost(
                                    story: story,
                                    title: getKey(story, ["title"], ""),
                                    lastSentence: getKey(
                                        story,
                                        [
                                          "last_sentence",
                                        ],
                                        AppStrings
                                            .thereAreNoSentencesToDisplay),
                                    profileModel: ProfileModel(
                                      profilePicture: "${getKey(story, [
                                            "creator_details",
                                            "profile_picture"
                                          ], "")}",
                                      name: "${getKey(story, [
                                            "creator_details",
                                            "name"
                                          ], "${AppStrings.appName} User")}",
                                      username: "${getKey(story, [
                                            "creator_details",
                                            "username"
                                          ], "")}",
                                      email: "${getKey(story, [
                                            "creator_details",
                                            "email"
                                          ], "")}",
                                      uid: "${getKey(story, [
                                            "creator_details",
                                            "uid"
                                          ], "")}",
                                    ),
                                    contributorsCount: getKey(
                                        story, ["contributors_count"], 0),
                                    liveNowCount:
                                        getKey(story, ["live_now_count"], 0),
                                    liveLimitCount:
                                        getKey(story, ["max_live"], 0),
                                    sentenceCount:
                                        getKey(story, ["sentence_count"], 0),
                                    likesCount:
                                        getKey(story, ["likes_count"], 0),
                                    createdAt:
                                        getKey(story, ["created_at"], ""),
                                    commentsCount:
                                        getKey(story, ["comments_count"], 0),
                                    maxSentences:
                                        getKey(story, ["max_sentence"], 0),
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
                )),
          );
        });
  }
}
