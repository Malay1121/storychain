import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../helper/all_imports.dart';

class ChatListController extends CommonController {
  DocumentSnapshot? lastDoc = null;
  List chatList = [];
  ScrollController scrollController = ScrollController();
  bool isLoading = false;
  bool hasMore = true;

  int limit = 10;
  @override
  void onInit() {
    super.onInit();
    getChatList();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (isTop) {
        } else {
          limit += 10;
          update();
        }
      }
    });
  }

  void onChatTap(String chatId, Map chat) {
    Get.toNamed(
      Routes.CHAT,
      arguments: {'chatId': chatId, 'chat': chat},
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getChatList({bool loadMore = false}) async {
    try {
      if (isLoading || (!hasMore && loadMore)) return;
      isLoading = true;
      Query query = FirebaseFirestore.instance
          .collection("chats")
          .where("users", arrayContains: user?.uid)
          .orderBy("updatedAt", descending: true)
          .limit(limit);
      if (lastDoc != null) {
        query = query.startAfterDocument(lastDoc!);
      }
      query.snapshots().listen((querySnapshot) async {
        List chats = [];
        for (QueryDocumentSnapshot query in querySnapshot.docs) {
          Map lastChat = (await DatabaseHelper.getChat(
                      chatId: query.id, limit: 1))
                  .isNotEmpty
              ? (await DatabaseHelper.getChat(chatId: query.id, limit: 1)).first
              : {};
          Map chatData = query.data() as Map;
          List userList = getKey(chatData, ["users"], []);
          String userB = userList.firstWhere(
            (element) => element != user?.uid,
          );
          Map userBDetails = await DatabaseHelper.getUser(userId: userB);
          Map chat = {
            "doc": query,
            "userB": userBDetails,
            "last_chat": lastChat,
          };
          chats.add(chat);
        }
        chatList.addAll(chats);
        update();
      });
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }
}
