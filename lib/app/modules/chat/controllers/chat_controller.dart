import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:storychain/app/helper/all_imports.dart';

class ChatController extends CommonController {
  String? chatId;
  List chats = [];
  Map chat = {};
  bool isLoading = false;

  TextEditingController messageController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      chatId = Get.arguments['chatId'];
      chat = Get.arguments['chat'];
      update();
    }
    if (isEmptyString(chatId)) {
      Get.offAllNamed(Routes.CHAT_LIST);
    }
  }

  void sendMessage() async {
    if (isEmptyString(messageController.text.trim())) return;
    isLoading = true;
    update();
    DatabaseHelper.sendMessage(
            message: messageController.text,
            chatId: chatId!,
            uid: user?.uid ?? "")
        .then((value) {
      messageController.clear();
      isLoading = false;
      update();
    }).catchError((error) {
      showFirebaseError(error.toString());
      isLoading = false;
      update();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
