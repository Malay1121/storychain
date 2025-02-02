import 'package:storychain/app/helper/all_imports.dart';

class SignupController extends AnonCommonController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  List genders = [AppStrings.male, AppStrings.female, AppStrings.other];
  int? selectedGender;

  void selectGender(String gender) {
    selectedGender = genders.indexOf(gender);
    update();
  }

  bool isGenderSelected(String gender) {
    return genders.indexOf(gender) == selectedGender;
  }

  int page = 0;
  int maxPage = 1;

  void next() {
    if (page < maxPage) {
      if (page0Validation()) {
        page++;
      }
    }
    update();
  }

  void previous() {
    if (page > 0) {
      page--;
    }
    update();
  }

  void signUp() async {
    if (page0Validation() && await page1Validation()) {
      EasyLoading.show();

      Map<String, dynamic> userDetails = {
        "name": nameController.text,
        "email": emailController.text,
        "password": generateMd5(passwordController.text),
      };
      await DatabaseHelper.createUser(data: userDetails);
      Get.toNamed(
        Routes.EMAIL_VERIFICATION,
        arguments: {"route": Routes.HOME},
      );
      EasyLoading.dismiss();
    }
  }

  void logIn() async {
    if (page0Validation() && await page1Validation()) {
      EasyLoading.show();
      Map<String, dynamic>? userDetails = {
        "name": nameController.text,
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

  bool page0Validation({bool snackbar = true}) {
    if (emailController.text.isEmpty || !validateEmail(emailController.text)) {
      if (snackbar == true) showSnackbar(message: AppStrings.emailValidation);
      return false;
    } else if (passwordController.text.isEmpty ||
        !validatePassword(passwordController.text)) {
      if (snackbar == true)
        showSnackbar(message: AppStrings.passwordValidation);
      return false;
    }
    return true;
  }

  Future<bool> page1Validation({bool snackbar = true}) async {
    if (isEmptyString(nameController.text)) {
      if (snackbar == true) showSnackbar(message: AppStrings.nameValidation);
      return false;
    } else if (isEmptyString(usernameController.text) ||
        !(await DatabaseHelper.usernameAvailable(
            username: usernameController.text))) {
      if (snackbar == true)
        showSnackbar(
            message: AppStrings.usernameIsEmpty +
                " or " +
                AppStrings.usernameAlreadyExists);
      return false;
    } else if (selectedGender == null) {
      if (snackbar == true) showSnackbar(message: AppStrings.genderValidation);
      return false;
    }
    return true;
  }

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
}
