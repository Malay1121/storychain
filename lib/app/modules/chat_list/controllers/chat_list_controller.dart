import 'package:get/get.dart';

import '../../../helper/all_imports.dart';

class ChatListController extends CommonController {
  DocumentSnapshot? lastDoc = null;
  List chatList = [];
  ScrollController scrollController = ScrollController();
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getChatList() async {
    try {
      dynamic query = FirebaseFirestore.instance
          .collection("chats")
          .where("users", arrayContains: user?.uid)
          .limit(limit);
      if (lastDoc != null) {
        query = query.startAfterDocument(lastDoc);
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
            "last_chat": lastChat
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
