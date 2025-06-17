// import 'package:appwrite/models.dart';
import 'package:storychain/app/helper/all_imports.dart';

class DatabaseHelper {
  static Future getApis() async {
    try {
      DocumentSnapshot documentSnapshot =
          await FirebaseFirestore.instance.collection("apis").doc("apis").get();
      apiKeys = documentSnapshot.data() != null
          ? documentSnapshot.data() as Map
          : apiKeys;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future updateApiIndex({required String apiName}) async {
    try {
      await FirebaseFirestore.instance
          .collection("apis")
          .doc("apis")
          .update(apiKeys[apiName]);
      return apiKeys[apiName];
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future usernameAvailable({required String username}) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("username", isEqualTo: username)
          .get();
      return querySnapshot.docs.isEmpty;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future createUser({required Map<String, dynamic> data}) async {
    try {
      // Account account = Account(client);
      // Functions functions = Functions(client);
      // User user = await account.create(
      //   userId: data["username"],
      //   email: data["email"],
      //   password: generateMd5(data["password"]),
      //   name: data["name"],
      // );
      // Future user = functions.createExecution(functionId: "create_user", method: ExecutionMethod.pOST, body: );
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: data["email"], password: generateMd5(data["password"]));
      if (user.user != null) {
        Reference storageRef = FirebaseStorage.instance.ref().child(
            "profile_pictures/${user.user!.uid}.${data["profile_picture"].toString().split(".").last}");
        await storageRef.putFile(
          File(
            data["profile_picture"],
          ),
        );
        String imagePath = await storageRef.getDownloadURL();
        data["profile_picture"] = imagePath;
        FirebaseAuth.instance.currentUser!
            .updateProfile(displayName: data["name"], photoURL: imagePath);
        data.addEntries({"uid": user.user!.uid}.entries);
        await FirebaseFirestore.instance
            .collection("users")
            .doc(data["uid"])
            .set(data);
        writeUserDetails(data);
      }
      return user.user;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future? loginUser({required Map<String, dynamic> data}) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: data["email"], password: generateMd5(data["password"]));
      Map<String, dynamic>? userData = (await FirebaseFirestore.instance
              .collection("users")
              .doc(user.user!.uid)
              .get())
          .data();
      if (userData != null) writeUserDetails(userData);
      return user;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future editUser(
      {required String userId, required Map<String, dynamic> data}) async {
    try {
      if (getKey(data, ["profile_picture"], "") is File) {
        Reference storageRef = FirebaseStorage.instance.ref().child(
            "profile_pictures/${userId}.${data["profile_picture"].toString().split(".").last}");
        await storageRef.putFile(
          data["profile_picture"],
        );
        String imagePath = await storageRef.getDownloadURL();
        data["profile_picture"] = imagePath;
      }

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .update(data);

      editUserDetails(data);

      return data;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future getUser({required String userId}) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get();
      return userSnapshot.data();
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future<List?> getStories(
      {DocumentSnapshot? lastDoc, String? uid, List? storySnapshots}) async {
    try {
      EasyLoading.show();
      List snapshots = [];
      dynamic userSnapshot;
      if (storySnapshots == null) {
        userSnapshot = FirebaseFirestore.instance.collection("story");

        if (uid != null) {
          userSnapshot = userSnapshot.where("creator", isEqualTo: uid);
        }
        if (lastDoc != null) {
          userSnapshot = userSnapshot.startAfterDocument(lastDoc);
        }

        userSnapshot = await userSnapshot.limit(5).get();
        snapshots = userSnapshot.docs;
      } else {
        for (var story in storySnapshots) {
          DocumentSnapshot localSnapshot = await FirebaseFirestore.instance
              .collection("story")
              .doc(story["story_id"])
              .get();
          snapshots.add(localSnapshot);
        }
      }

      List stories = [];
      for (var element in snapshots) {
        var data = element.data() as Map? ?? {};
        DocumentSnapshot userDetailSnapshot = await FirebaseFirestore.instance
            .collection("users")
            .doc(data["creator"])
            .get();
        AggregateQuerySnapshot commentCount = await FirebaseFirestore.instance
            .collection("story")
            .doc(element.id)
            .collection("comments")
            .count()
            .get();
        AggregateQuerySnapshot likesCount = await FirebaseFirestore.instance
            .collection("likes")
            .where("story_id", isEqualTo: element.id)
            .count()
            .get();
        AggregateQuerySnapshot liveNowCount = await FirebaseFirestore.instance
            .collection("story")
            .doc(element.id)
            .collection("live_now")
            .count()
            .get();
        AggregateQuerySnapshot contributorsCount = await FirebaseFirestore
            .instance
            .collection("contributors")
            .where("story_id", isEqualTo: element.id)
            .count()
            .get();
        QuerySnapshot lastSentence = await FirebaseFirestore.instance
            .collection("sentences")
            .where("story_id", isEqualTo: element.id)
            .orderBy("created_at", descending: true)
            .limit(1)
            .get();
        AggregateQuerySnapshot sentenceCount = await FirebaseFirestore.instance
            .collection("sentences")
            .where("story_id", isEqualTo: element.id)
            .count()
            .get();

        data.addEntries({
          "doc": element,
          "creator_details": userDetailSnapshot.data() ?? {},
          "comment_count": commentCount.count,
          "likes_count": likesCount.count,
          "live_now_count": liveNowCount.count,
          "contributors_count": contributorsCount.count,
          "last_sentence": lastSentence.docs.isNotEmpty
              ? lastSentence.docs.first.data()
              : null,
          "sentence_count": sentenceCount.count,
        }.entries);
        print("storyyyyy: ${data}");
        stories.add(data);
      }
      EasyLoading.dismiss();

      return stories;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
      EasyLoading.dismiss();
    }
    return null;
  }

  static Future getContributedStories({required String uid}) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("contributors")
          .where("user_id", isEqualTo: uid)
          .get();
      List stories = [];
      for (QueryDocumentSnapshot query in querySnapshot.docs) {
        stories.add({"story_id": (query.data() as Map)["story_id"]});
      }

      return await getStories(storySnapshots: stories);
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future sendSentence({
    required String sentence,
    required String storyId,
    required String uid,
  }) async {
    try {
      EasyLoading.show();
      await FirebaseFirestore.instance.collection("sentences").add({
        "sentence": sentence,
        "story_id": storyId,
        "contributor_id": uid,
        "created_at": toUtc(DateTime.now()),
      }).then(
        (value) async {
          await FirebaseFirestore.instance
              .collection("sentences")
              .doc(value.id)
              .update({
            "id": value.id,
          });
        },
      );
      EasyLoading.dismiss();
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
      EasyLoading.dismiss();
    }
  }

  static Future sendChat({
    required String message,
    required String storyId,
    required String uid,
  }) async {
    try {
      EasyLoading.show();
      await FirebaseFirestore.instance
          .collection("story")
          .doc(storyId)
          .collection("chat")
          .add({
        "message": message,
        "sender": uid,
        "created_at": toUtc(DateTime.now()),
      }).then(
        (value) async {
          await FirebaseFirestore.instance
              .collection("sentences")
              .doc(value.id)
              .update({
            "id": value.id,
          });
        },
      );
      EasyLoading.dismiss();
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
      EasyLoading.dismiss();
    }
  }

  static Future likeStory(
      {required String storyId, required String uid}) async {
    try {
      EasyLoading.show();
      if (await storyLiked(storyId: storyId, uid: uid)) {
        await FirebaseFirestore.instance
            .collection("likes")
            .where("user_id", isEqualTo: uid)
            .where("story_id", isEqualTo: storyId)
            .get()
            .then((value) => FirebaseFirestore.instance
                .collection("likes")
                .doc(value.docs.first.id)
                .delete());
      } else {
        await FirebaseFirestore.instance.collection("likes").add({
          "user_id": uid,
          "story_id": storyId,
          "created_at": toUtc(DateTime.now()),
        });
      }
      EasyLoading.dismiss();
      return;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future<bool> storyLiked(
      {required String storyId, required String uid}) async {
    try {
      bool liked = await FirebaseFirestore.instance
          .collection("likes")
          .where("user_id", isEqualTo: uid)
          .where("story_id", isEqualTo: storyId)
          .get()
          .then((value) => value.docs.isNotEmpty);
      return liked;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
      return false;
    }
  }

  static Future addContributor(
      {required String storyId, required String uid}) async {
    try {
      EasyLoading.show();
      await FirebaseFirestore.instance.collection("contributors").add({
        "user_id": uid,
        "story_id": storyId,
        "created_at": toUtc(DateTime.now()),
      });
      EasyLoading.dismiss();
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
      EasyLoading.dismiss();
    }
  }

  static Future addStory({
    required String starterSentence,
    required int maxSentences,
    required int maxLive,
    required String uid,
  }) async {
    try {
      EasyLoading.show();
      DocumentReference storyRef =
          await FirebaseFirestore.instance.collection("story").add({
        "creator": uid,
        "created_at": toUtc(DateTime.now()),
        "max_sentence": maxSentences,
        "title": starterSentence,
        "max_live": maxLive,
      });

      await FirebaseFirestore.instance
          .collection("story")
          .doc(storyRef.id)
          .update({"id": storyRef.id});
      await sendSentence(
          sentence: starterSentence, storyId: storyRef.id, uid: uid);
      await addContributor(storyId: storyRef.id, uid: uid);

      EasyLoading.dismiss();
      return storyRef.id;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
      EasyLoading.dismiss();
    }
  }

  static Future getStoryCount({required String? uid}) async {
    dynamic ref = FirebaseFirestore.instance.collection("story");
    if (uid != null && uid.isNotEmpty) {
      ref = ref.where("creator", isEqualTo: uid);
    }
    print((await (ref.count() as AggregateQuery).get()).count);

    print("await ref.count()");
    return (await ref.count().get()).count;
  }

  static Future getFollowerCount({required String? uid}) async {
    dynamic ref = FirebaseFirestore.instance.collection("following");
    if (uid != null && uid.isNotEmpty) {
      ref = ref.where("following", isEqualTo: uid);
    }
    return (await ref.count().get()).count;
  }

  static Future getFollowingCount({required String? uid}) async {
    dynamic ref = FirebaseFirestore.instance.collection("following");
    if (uid != null && uid.isNotEmpty) {
      ref = ref.where("follower", isEqualTo: uid);
    }
    return (await ref.count().get()).count;
  }

  static Future getChatList(
      {required String uid, DocumentSnapshot? lastDoc, int limit = 10}) async {
    try {
      dynamic querySnapshot = FirebaseFirestore.instance
          .collection("chats")
          .where("users", arrayContains: uid)
          .limit(limit);
      if (lastDoc != null) {
        querySnapshot = querySnapshot.startAfterDocument(lastDoc);
      }
      querySnapshot = await querySnapshot.get();
      List chats = [];
      for (QueryDocumentSnapshot query in querySnapshot.docs) {
        Map lastChat = (await getChat(chatId: query.id, limit: 1)).first;
        Map chatData = query.data() as Map;
        List userList = getKey(chatData, ["users"], []);
        String userB = userList.firstWhere(
          (element) => element != uid,
        );
        Map userBDetails = await getUser(userId: userB);
        Map chat = {"doc": query, "userB": userBDetails, "last_chat": lastChat};
        chats.add(chat);
      }
      return chats;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future<List> getChat(
      {required String chatId,
      DocumentSnapshot? lastDoc,
      int limit = 15}) async {
    dynamic querySnapshot = FirebaseFirestore.instance
        .collection("chats")
        .doc(chatId)
        .collection("chats")
        .limit(limit);
    if (lastDoc != null) {
      querySnapshot = querySnapshot.startAfterDocument(lastDoc);
    }
    querySnapshot = await querySnapshot.get();
    List chats = [];
    for (QueryDocumentSnapshot query in querySnapshot.docs) {
      Map chat = {"data": query.data() as Map, "doc": query};
      chats.add(chat);
    }
    return chats;
  }
}
