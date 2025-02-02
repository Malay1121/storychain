import 'package:get/get.dart';
import 'package:storychain/app/helper/all_imports.dart';

class SigninController extends AnonCommonController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void submit() async {
    if (validation()) {
      EasyLoading.show();
      Map<String, dynamic>? userDetails = {
        "email": emailController.text,
        "password": generateMd5(passwordController.text),
      };
      UserCredential? result =
          await DatabaseHelper.loginUser(data: userDetails);
      if (result != null) {
        if (result.user != null) {
          if (result.user!.emailVerified) {
            Get.offAllNamed(Routes.HOME);
          } else {
            Get.toNamed(
              Routes.EMAIL_VERIFICATION,
              arguments: {"route": Routes.HOME},
            );
          }
        }
      }
      EasyLoading.dismiss();
    }
  }

  bool validation({bool snackbar = true}) {
    if (emailController.text.isEmpty || !validateEmail(emailController.text)) {
      if (snackbar) showSnackbar(message: AppStrings.emailValidation);
      return false;
    } else if (passwordController.text.isEmpty ||
        !validatePassword(passwordController.text)) {
      if (snackbar) showSnackbar(message: AppStrings.passwordValidation);
      return false;
    }
    return true;
  }
}
