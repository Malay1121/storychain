import 'package:storychain/app/helper/all_imports.dart';
import 'package:appwrite/appwrite.dart';

Client client = Client();
RxMap firebaseUser = RxMap();
void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  client = Client();
  client.setProject('storychain');

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAMNnXtWUQf-3dtUBn-b1kmuiP5tTZdbzg",
          appId: "1:269721728762:android:abdf6a360dcd6d5a207b43",
          messagingSenderId: "269721728762",
          projectId: "storychain-app",
          storageBucket: "storychain-app.firebasestorage.app"));
  initializeSize(428, 926);
  configureEasyLoading();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorStyle.othersWhite,
      ),
      alignment: Alignment.center,
      child: AppText(
        text: 'Error!\n${details.exception}',
        style: TextStyle(color: ColorStyle.greyscale900),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      ),
    );
  };

  runApp(
    GetMaterialApp(
      title: "Application",
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
