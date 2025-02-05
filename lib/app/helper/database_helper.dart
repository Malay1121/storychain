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

  static Future getUser({required User user}) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      return userSnapshot.data();
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future<List?> getStories({DocumentSnapshot? lastDoc}) async {
    try {
      dynamic userSnapshot = FirebaseFirestore.instance.collection("story");
      if (lastDoc != null) {
        userSnapshot = userSnapshot.startAfterDocument(lastDoc);
      }
      userSnapshot = await userSnapshot.limit(10).get();
      List stories = [];
      (userSnapshot as QuerySnapshot).docs.forEach(
        (element) async {
          var data = element.data() as Map? ?? {};
          DocumentSnapshot userDetailSnapshot = await FirebaseFirestore.instance
              .collection("users")
              .doc(data["uid"])
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

          data.addEntries({
            "doc": element,
            "creator_details": userDetailSnapshot.data()!,
            "comment_count": commentCount.count,
            "likes_count": likesCount.count,
          }.entries);
          stories.add(element.data());
        },
      );

      return stories;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
    return null;
  }
}
