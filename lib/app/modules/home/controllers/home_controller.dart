import 'dart:ffi';

import 'package:get/get.dart';
import 'package:storychain/app/helper/all_imports.dart';

class HomeController extends CommonController {
  Map? lastStory = null;
  List stories = [];
  bool loading = false;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getStories();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (isTop) {

        } else {
          getStories();
        }
      }
    });
    userStream = FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .snapshots()
        .listen(
      (event) {
        userDetails = event.data() ?? {};
        print("userDetails: $userDetails");
        firebaseUser.value = {"user": user};
        update();
      },
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

  Future getStories() async {
    loading = true;
    update();
    var response = await DatabaseHelper.getStories(lastDoc: getKey(lastStory ?? {}, ["doc"], null));
    print(response);
    lastStory = response != null ? response.last : lastStory;
    if (response != null) {
      stories.addAll(response);
    }
    loading = false;
    update();
  }
}
