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
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w(context),
                  ),
                  child: Column(
                    children: [
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: "Story title",
                              style: Styles.bodyLargeSemibold(
                                color: ColorStyle.greyscale900,
                              ),
                            ),
                            SizedBox(
                              height: 10.h(context),
                            ),
                            Row(
                              children: [
                                AppText(
                                  text: "Story description",
                                  style: Styles.bodyLargeSemibold(
                                    color: ColorStyle.greyscale900,
                                  ),
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    AppText(
                                      text: "Sentences",
                                      style: Styles.bodyMediumRegular(
                                        color: ColorStyle.greyscale900,
                                      ),
                                    ),
                                    AppText(
                                      text: "3/10",
                                      style: Styles.h2Bold(
                                        color: ColorStyle.primary500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            CommonButton(
                              text: AppStrings.contribute,
                              onTap: () => null,
                              width: 332.w(context),
                              height: 58.h(context),
                            ),
                          ],
                        ),
                      ),
                      CommonBottomBar(
                        selectedTab: AppStrings.home,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
