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
    return Container(
      width: 220.w(context),
      height: 35.h(context),
      child: Row(
        children: [
          for (Map tab in tabs)
            Expanded(
              child: GestureDetector(
                onTap: () => Get.toNamed(tab["page"]),
                child: Container(
                  height: 35.h(context),
                  decoration: BoxDecoration(
                    color: ColorStyle.othersWhite,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        tab["icon"],
                        color: tab["title"] == widget.selectedTab
                            ? ColorStyle.primary500
                            : ColorStyle.greyscale500,
                        size: 12.t(context),
                      ),
                      if (tab["title"] == widget.selectedTab)
                        AppText(
                          text: tab["title"],
                          height: 12.h(context),
                          centered: true,
                          style: TextStyle(
                            color: ColorStyle.primary500,
                            fontFamily: SfProDisplay,
                            fontWeight: FontWeight.w500,
                            fontSize: 8.t(context),
                          ),
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
