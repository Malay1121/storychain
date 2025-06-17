import 'package:flutter/material.dart';
import 'package:flutter_responsive_helper/flutter_responsive_helper.dart';

import 'package:get/get.dart';
import 'package:storychain/app/helper/figma_styles.dart';

import '../../../helper/all_imports.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorStyle.othersWhite,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
              child: Column(
                children: [
                  SizedBox(
                    height: 24.h(context),
                  ),
                  SizedBox(
                    height: 48.h(context),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: ColorStyle.greyscale900,
                            size: 28.t(context),
                          ),
                        ),
                        SizedBox(
                          width: 16.w(context),
                        ),
                        CommonImage(
                          imageUrl: getKey(controller.chat,
                              ["userB", "profile_picture"], ""),
                          fit: BoxFit.cover,
                          type: "network",
                          borderRadius: BorderRadius.circular(100),
                          height: 40.h(context),
                          width: 40.h(context),
                        ),
                        SizedBox(
                          width: 10.w(context),
                        ),
                        AppText(
                          text: getKey(controller.chat, ["userB", "name"], ""),
                          style: Styles.h4Bold(
                            color: ColorStyle.greyscale900,
                          ),
                        ),
                        // SizedBox(
                        //   width: 24.w(context),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h(context),
                  ),
                  Expanded(
                    child: FirestorePagination(
                      query: FirebaseFirestore.instance
                          .collection("chats")
                          .doc(controller.chatId)
                          .collection("chats")
                          .orderBy("created_at", descending: true),
                      reverse: true,
                      isLive: true,
                      viewType: ViewType.list,
                      itemBuilder: (context, documentSnapshot, index) {
                        final message = documentSnapshot[index].data()
                            as Map<String, dynamic>?;
                        if (message == null) {
                          return SizedBox.shrink();
                        }
                        final bool isSender =
                            getKey(message, ['senderId'], "u") ==
                                controller.user?.uid;
                        return Row(
                          mainAxisAlignment: isSender
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: 300.w(context),
                              ),
                              margin: EdgeInsets.only(bottom: 24.h(context)),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w(context),
                                vertical: 12.h(context),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: isSender
                                    ? BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(16),
                                        bottomLeft: Radius.circular(16),
                                        topLeft: Radius.circular(16),
                                      )
                                    : BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                        bottomRight: Radius.circular(16)),
                                color: isSender
                                    ? ColorStyle.primary500
                                    : ColorStyle.greyscale100,
                              ),
                              child: Column(
                                crossAxisAlignment: isSender
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    text: getKey(message, ['message'], ""),
                                    style: Styles.bodyLargeRegular(
                                      color: isSender
                                          ? ColorStyle.othersWhite
                                          : ColorStyle.greyscale900,
                                    ),
                                    maxLines: null,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 4.h(context),
                                  ),
                                  AppText(
                                    text: formatDateTimeDifference(
                                                fromUtc(getKey(
                                                    message,
                                                    ['created_at'],
                                                    toUtc(DateTime.now()))),
                                                DateTime.now())
                                            .toString() +
                                        " ago",
                                    style: Styles.bodySmallRegular(
                                      color: isSender
                                          ? ColorStyle.othersWhite
                                          : ColorStyle.greyscale600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16.h(context),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 48.h(context)),
                    child: Row(
                      children: [
                        CommonTextField(
                          hintText: AppStrings.writeMessage,
                          controller: controller.messageController,
                          maxLines: null,
                          suffixIcon: SizedBox(),
                          width: 312,
                          // height: 56,
                        ),
                        SizedBox(
                          width: 12.w(context),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.sendMessage();
                          },
                          child: Container(
                            height: 56.h(context),
                            width: 56.w(context),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorStyle.primary500,
                            ),
                            child: Icon(
                              Icons.send,
                              color: ColorStyle.othersWhite,
                              size: 24.t(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
