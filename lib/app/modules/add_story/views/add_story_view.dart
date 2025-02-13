import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:storychain/app/helper/all_imports.dart';

import '../controllers/add_story_controller.dart';

class AddStoryView extends GetView<AddStoryController> {
  const AddStoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddStoryController>(
        init: AddStoryController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: ColorStyle.othersWhite,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 33.5.h(context),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          AppStrings.createStory,
                          style: Styles.h4Bold(color: ColorStyle.greyscale900),
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
                    CommonTextField(
                      hintText: AppStrings.starterSentence,
                      controller: controller.starterSentenceController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 20.h(context),
                    ),
                    CommonTextField(
                      hintText: AppStrings.maxLive,
                      controller: controller.maxLiveController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    SizedBox(
                      height: 20.h(context),
                    ),
                    CommonTextField(
                      hintText: AppStrings.maxSentence,
                      controller: controller.maxSentencesController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    SizedBox(
                      height: 30.h(context),
                    ),
                    CommonButton(
                      text: AppStrings.createStory,
                      enabled: controller.validation(),
                      onTap: () => controller.addStory(),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
