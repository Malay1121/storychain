import 'package:storychain/app/helper/all_imports.dart';

class CommonBottomBar extends StatefulWidget {
  CommonBottomBar({
    super.key,
    required this.selectedTab,
  });
  String selectedTab;
  @override
  State<CommonBottomBar> createState() => _CommonBottomBarState();
}

class _CommonBottomBarState extends State<CommonBottomBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 428.w(context),
      height: 90.h(context),
      child: Row(
        children: [
          for (Map tab in tabs)
            Expanded(
              child: GestureDetector(
                onTap: () => Get.toNamed(tab["page"],
                    arguments: tab["title"] == AppStrings.profile
                        ? {
                            "userId": getKey(userDetails, ["uid"], "")
                          }
                        : null),
                child: Container(
                  height: 48.h(context),
                  decoration: BoxDecoration(
                    color: ColorStyle.othersWhite,
                  ),
                  child: tab["title"] == AppStrings.createStory
                      ? Container(
                          decoration: BoxDecoration(
                            color: ColorStyle.primary500,
                            shape: BoxShape.circle,
                          ),
                          width: 40.w(context),
                          height: 40.w(context),
                          child: Center(
                            child: Icon(
                              tab["icon"],
                              size: 24.t(context),
                              color: ColorStyle.othersWhite,
                            ),
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              tab["icon"],
                              color: tab["title"] == widget.selectedTab
                                  ? ColorStyle.primary500
                                  : ColorStyle.greyscale500,
                              size: 24.t(context),
                            ),
                            if (tab["title"] == widget.selectedTab)
                              AppText(
                                text: tab["title"],
                                height: 12.h(context),
                                centered: true,
                                style: Styles.bodyXsmallBold(
                                    color: ColorStyle.primary500),
                              ),
                          ],
                        ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
