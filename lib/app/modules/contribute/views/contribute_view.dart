import 'package:storychain/app/helper/all_imports.dart';

import '../controllers/contribute_controller.dart';

class ContributeView extends GetView<ContributeController> {
  const ContributeView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContributeController>(
        init: ContributeController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: ColorStyle.othersWhite,
              body: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w(context),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 33.5.h(context),
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: ColorStyle.othersWhite,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: ColorStyle.othersBlack.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.w(context),
                                ),
                                child: Row(
                                  children: [],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    StreamBuilder(
                      stream: controller.story.stream,
                      builder: (context, snapshot) {
                        Map story = snapshot.data ?? {};
                        if (getKey(story, ["story"], {}) == {}) {
                          return CircularProgressIndicator();
                        } else {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: ColorStyle.greyscale900,
                                      size: 28.t(context),
                                    ),
                                  ),
                                  Text(
                                    AppStrings.contribute,
                                    style: Styles.h4Bold(
                                        color: ColorStyle.greyscale900),
                                  ),
                                  Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.transparent,
                                    size: 28.t(context),
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
                                    width: 94.w(context),
                                    child: Column(
                                      children: [
                                        AppText(
                                          text: AppStrings.contributors,
                                          style: Styles.bodyMediumRegular(
                                            color: ColorStyle.greyscale900,
                                          ),
                                        ),
                                        AppText(
                                          text: "${getKey(story, [
                                                "contributors",
                                              ], []).length}",
                                          style: Styles.h3Bold(
                                            color: ColorStyle.othersPurple,
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
                                    width: 94.w(context),
                                    child: Column(
                                      children: [
                                        AppText(
                                          text: AppStrings.liveNow,
                                          style: Styles.bodyMediumRegular(
                                            color: ColorStyle.greyscale900,
                                          ),
                                        ),
                                        AppText(
                                          text: "${getKey(story, [
                                                "story",
                                                "contributors_count"
                                              ], 0)}",
                                          style: Styles.h3Bold(
                                            color: ColorStyle.greyscale900,
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
                                    width: 94.w(context),
                                    child: Column(
                                      children: [
                                        AppText(
                                          text: AppStrings.liveLimit,
                                          style: Styles.bodyMediumRegular(
                                            color: ColorStyle.greyscale900,
                                          ),
                                        ),
                                        GestureDetector(
                                          child: AppText(
                                            text: "${getKey(story, [
                                                  "story",
                                                  "max_live"
                                                ], 0)}",
                                            style: Styles.h3Bold(
                                              color: ColorStyle.secondary500,
                                            ),
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
                                    width: 94.w(context),
                                    child: Column(
                                      children: [
                                        AppText(
                                          text: AppStrings.sentences,
                                          style: Styles.bodyMediumRegular(
                                            color: ColorStyle.greyscale900,
                                          ),
                                        ),
                                        GestureDetector(
                                          child: AppText(
                                            text: "${getKey(story, [
                                                  "sentences",
                                                  "sentences"
                                                ], []).length}/${getKey(story, [
                                                  "story",
                                                  "max_sentence"
                                                ], 0)}",
                                            style: Styles.h3Bold(
                                              color: ColorStyle.secondary500,
                                            ),
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
                              GestureDetector(
                                child: AppText(
                                  text: getKey(story, ["story", "title"],
                                      AppStrings.storyTitle),
                                  style: Styles.h5Bold(
                                    color: ColorStyle.greyscale900,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 24.h(context),
                              ),
                              SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 24.h(context),
                                  ),
                                  child: Text.rich(
                                    TextSpan(
                                      text: "",
                                      style: Styles.bodyLargeMedium(
                                          color: ColorStyle.greyscale900),
                                      children: [
                                        for (var sentence in getKey(
                                            story,
                                            ["sentences", "sentences"],
                                            [])) ...[
                                          WidgetSpan(
                                            child: CommonImage(
                                              imageUrl: getKey(
                                                  controller.getContributor(
                                                      getKey(
                                                          sentence,
                                                          ["contributor_id"],
                                                          "")),
                                                  ["profile_picture"],
                                                  ""),
                                              fit: BoxFit.cover,
                                              width: 25.h(context),
                                              height: 25.h(context),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                          ),
                                          WidgetSpan(
                                            child: SizedBox(
                                              width: 6.w(context),
                                            ),
                                          ),
                                          TextSpan(
                                            text: getKey(
                                              sentence,
                                              ["sentence"],
                                              AppStrings.storySentence,
                                            ),
                                            style: Styles.bodyLargeMedium(
                                              color: ColorStyle.greyscale900,
                                            ),
                                          ),
                                          WidgetSpan(
                                            child: SizedBox(
                                              width: 10.w(context),
                                            ),
                                          ),
                                        ]
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if (getKey(story, ["sentences", "sentences"], [])
                                  .isEmpty)
                                AppText(
                                  text: AppStrings.thereAreNoSentencesToDisplay,
                                  style: Styles.h5Bold(
                                      color: ColorStyle.alertsStatusError),
                                ),
                            ],
                          );
                        }
                      },
                    ),
                    Spacer(),
                    CommonTextField(
                      hintText: AppStrings.writeSentence,
                      controller: controller.sentenceController,
                      suffixIcon: CommonButton(
                        onTap: () => controller.sendSentence(),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        text: AppStrings.send,
                        width: 80.w(context),
                        height: 30.h(context),
                      ),
                    ),
                    SizedBox(
                      height: 24.h(context),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
