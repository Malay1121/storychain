import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/modules/chat_list/controllers/chat_list_controller.dart';

class ChatListView extends GetView<ChatListController> {
  const ChatListView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatListController>(
      init: ChatListController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorStyle.othersWhite,
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w(context),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 34.h(context),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 16.w(context),
                              ),
                              AppText(
                                text: AppStrings.messages,
                                style: Styles.h4Bold(
                                  color: ColorStyle.greyscale900,
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 33.5.h(context),
                          ),
                          CommonTextField(
                            hintText: AppStrings.search,
                          ),
                          SizedBox(
                            height: 24.h(context),
                          ),
                          AppText(
                            text: AppStrings.recently,
                            style: Styles.h5Bold(
                              color: ColorStyle.greyscale900,
                            ),
                          ),
                          SizedBox(
                            height: 24.h(context),
                          ),
                          SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CommonImage(
                                      imageUrl:
                                          "https://firebasestorage.googleapis.com/v0/b/storychain-app.firebasestorage.app/o/profile_pictures%2FdIbvqmvZ1hP5OuIMwlJVXbOmGKy2.jpg?alt=media&token=ae48221a-bfe0-42ea-af3f-c5044cd3f1b9",
                                      fit: BoxFit.cover,
                                      width: 80.h(context),
                                      height: 80.h(context),
                                      borderRadius: BorderRadius.circular(100),
                                      type: "network",
                                    ),
                                    SizedBox(
                                      height: 4.h(
                                        context,
                                      ),
                                    ),
                                    AppText(
                                      text: "Gaurav Anghan",
                                      style: Styles.bodyMediumSemibold(
                                        color: ColorStyle.greyscale900,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 24.h(context),
                          ),
                          AppText(
                            text: AppStrings.messages,
                            style: Styles.h5Bold(
                              color: ColorStyle.greyscale900,
                            ),
                          ),
                          SizedBox(
                            height: 24.h(context),
                          ),
                          for (Map chat in controller.chatList)
                            GestureDetector(
                              onTap: () {
                                controller.onChatTap(
                                    getKey(chat["doc"].data(), ["id"], ""),
                                    chat);
                              },
                              child: Row(
                                children: [
                                  CommonImage(
                                    imageUrl: getKey(
                                        chat, ["userB", "profile_picture"], ""),
                                    fit: BoxFit.cover,
                                    height: 60.w(context),
                                    width: 60.w(context),
                                    borderRadius: BorderRadius.circular(100),
                                    type: "network",
                                  ),
                                  SizedBox(
                                    width: 20.w(context),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 7.h(context),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 4.h(context),
                                      children: [
                                        AppText(
                                          text: getKey(
                                              chat, ["userB", "name"], ""),
                                          style: Styles.h6Bold(
                                            color: ColorStyle.greyscale900,
                                          ),
                                        ),
                                        AppText(
                                          text: getKey(chat,
                                              ["last_chat", "message"], ""),
                                          style: Styles.bodyMediumMedium(
                                            color: ColorStyle.greyscale700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      AppText(
                                        text: getKey(
                                                    chat,
                                                    ["last_chat", "created_at"],
                                                    "") !=
                                                ""
                                            ? formatDateTime(fromUtc(getKey(
                                                chat,
                                                ["last_chat", "created_at"],
                                                "")))
                                            : "",
                                        style: Styles.bodyMediumMedium(
                                          color: ColorStyle.greyscale700,
                                        ),
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
                CommonBottomBar(
                  selectedTab: AppStrings.chat,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
