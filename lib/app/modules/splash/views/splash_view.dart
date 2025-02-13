import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:storychain/app/helper/all_imports.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: ColorStyle.othersWhite,
            body: Center(
              child: CommonImage(
                imageUrl: AppImages.logo,
                fit: BoxFit.fitWidth,
                type: "asset",
                width: 150.w(context),
                height: 150.w(context),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          );
        });
  }
}
