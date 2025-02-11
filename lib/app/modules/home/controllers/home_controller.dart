import 'dart:ffi';

import 'package:get/get.dart';
import 'package:storychain/app/helper/all_imports.dart';

class HomeController extends CommonController {
  Map? lastStory = null;
  List stories = [];
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    getStories();
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
    var response = await DatabaseHelper.getStories();
    print(response);
    if (response != null) {
      stories.addAll(response);
    }
    loading = false;
    update();
  }
}
