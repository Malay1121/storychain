import 'package:appwrite/enums.dart';
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
      {required User user, required Map<String, dynamic> data}) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .update(data);
      editUserDetails(data);
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

        userSnapshot = await userSnapshot.limit(10).get();
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
            .collection("story")
            .doc(element.id)
            .collection("likes")
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
            .collection("story")
            .doc(element.id)
            .collection("sentences")
            .orderBy("created_at", descending: true)
            .limit(1)
            .get();
        AggregateQuerySnapshot sentenceCount = await FirebaseFirestore.instance
            .collection("story")
            .doc(element.id)
            .collection("sentences")
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

      return stories;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
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
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }
}
