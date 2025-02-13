import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:storychain/app/helper/all_imports.dart';

import '../controllers/user_profile_controller.dart';

class UserProfileView extends GetView<UserProfileController> {
  const UserProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProfileController>(
      init: UserProfileController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorStyle.othersWhite,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w(context),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 34.5.h(context),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: Icon(
                                  Icons.arrow_back_outlined,
                                  color: ColorStyle.greyscale900,
                                  size: 28.t(context),
                                ),
                              ),
                              AppText(
                                text: getKey(controller.userProfile, ["name"],
                                    AppStrings.profile),
                                style: Styles.h4Bold(
                                  color: ColorStyle.greyscale900,
                                ),
                              ),
                              GestureDetector(
                                child: Icon(
                                  Icons.settings_outlined,
                                  color: Colors.transparent,
                                  size: 28.t(context),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 34.h(context),
                          ),
                          CommonImage(
                            imageUrl: getKey(controller.userProfile,
                                    ["profile_picture"], null) ??
                                AppImages.profilePicture,
                            type: "network",
                            fit: BoxFit.cover,
                            borderRadius: BorderRadius.circular(100),
                            width: 120.h(context),
                            height: 120.h(context),
                          ),
                          SizedBox(
                            height: 12.h(context),
                          ),
                          AppText(
                            text: "@${getKey(controller.userProfile, [
                                  "username"
                                ], AppStrings.profile)}",
                            style: Styles.h5Bold(
                              color: ColorStyle.greyscale900,
                            ),
                          ),
                          SizedBox(
                            height: 8.h(context),
                          ),
                          AppText(
                            text: "Designer & Videographer",
                            style: Styles.bodyMediumMedium(
                              color: ColorStyle.greyscale900,
                            ),
                          ),
                          SizedBox(
                            height: 20.h(context),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 94.w(context),
                                child: Column(
                                  children: [
                                    AppText(
                                      text: "247",
                                      style: Styles.h4Bold(
                                        color: ColorStyle.greyscale900,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4.h(context),
                                    ),
                                    AppText(
                                      text: AppStrings.posts,
                                      style: Styles.bodyMediumMedium(
                                        color: ColorStyle.greyscale900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 53.h(context),
                                width: 1,
                                color: ColorStyle.greyscale200,
                              ),
                              SizedBox(
                                width: 94.w(context),
                                child: Column(
                                  children: [
                                    AppText(
                                      text: "368k",
                                      style: Styles.h4Bold(
                                        color: ColorStyle.greyscale900,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4.h(context),
                                    ),
                                    AppText(
                                      text: AppStrings.posts,
                                      style: Styles.bodyMediumMedium(
                                        color: ColorStyle.greyscale900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 53.h(context),
                                width: 1,
                                color: ColorStyle.greyscale200,
                              ),
                              SizedBox(
                                width: 94.w(context),
                                child: Column(
                                  children: [
                                    AppText(
                                      text: "374",
                                      style: Styles.h4Bold(
                                        color: ColorStyle.greyscale900,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4.h(context),
                                    ),
                                    AppText(
                                      text: AppStrings.posts,
                                      style: Styles.bodyMediumMedium(
                                        color: ColorStyle.greyscale900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 53.h(context),
                                width: 1,
                                color: ColorStyle.greyscale200,
                              ),
                              SizedBox(
                                width: 94.w(context),
                                child: Column(
                                  children: [
                                    AppText(
                                      text: "3.7M",
                                      style: Styles.h4Bold(
                                        color: ColorStyle.greyscale900,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4.h(context),
                                    ),
                                    AppText(
                                      text: AppStrings.posts,
                                      style: Styles.bodyMediumMedium(
                                        color: ColorStyle.greyscale900,
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
                            text: AppStrings.follow,
                            onTap: () => null,
                          ),
                          SizedBox(
                            height: 32.h(context),
                          ),
                          for (var contributedStory
                              in controller.contributedStories)
                            CommonPost(
                              story: contributedStory,
                              title: getKey(contributedStory, ["title"], ""),
                              contributorsCount: getKey(
                                  contributedStory, ["contributors_count"], 0),
                              lastSentence: getKey(
                                  contributedStory, ["last_sentence"], ""),
                              liveNowCount: getKey(
                                  contributedStory, ["live_now_count"], 0),
                              liveLimitCount:
                                  getKey(contributedStory, ["max_live"], 0),
                              likesCount:
                                  getKey(contributedStory, ["likes_count"], 0),
                              commentsCount: getKey(
                                  contributedStory, ["comment_count"], 0),
                              maxSentences:
                                  getKey(contributedStory, ["max_sentence"], 0),
                              profileModel: ProfileModel(
                                username: getKey(contributedStory,
                                    ["creator_details", "username"], ""),
                                uid: getKey(contributedStory,
                                    ["creator_details", "uid"], ""),
                                email: getKey(contributedStory,
                                    ["creator_details", "email"], ""),
                                name: getKey(contributedStory,
                                    ["creator_details", "name"], ""),
                                profilePicture: getKey(contributedStory,
                                    ["creator_details", "profile_picture"], ""),
                              ),
                              sentenceCount: getKey(
                                  contributedStory, ["sentence_count"], 0),
                              createdAt: getKey(
                                  contributedStory,
                                  ["created_at"],
                                  "2024-09-12 18:04:23.004584Z"),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                CommonBottomBar(
                  selectedTab: AppStrings.profile,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
