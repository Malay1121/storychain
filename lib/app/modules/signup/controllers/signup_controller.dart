import 'package:storychain/app/helper/all_imports.dart';

class SignupController extends AnonCommonController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  List genders = [AppStrings.male, AppStrings.female, AppStrings.other];
  int? selectedGender;

  File? profilePicture;

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

  void pickImage(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      profilePicture = File(image.path);
      update();
    }
    Get.back();
  }

  void selectProfilePicture() async {
    Get.bottomSheet(
      Container(
        width: 428.w(Get.context!),
        height: 266.h(Get.context!),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: ColorStyle.othersWhite,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 8.h(Get.context!),
            ),
            Container(
              width: 38.w(Get.context!),
              height: 3.h(Get.context!),
              color: ColorStyle.greyscale300,
            ),
            SizedBox(
              height: 24.h(Get.context!),
            ),
            AppText(
              text: AppStrings.selectImageSource,
              style: Styles.h4Bold(
                color: ColorStyle.greyscale900,
              ),
            ),
            SizedBox(
              height: 32.h(Get.context!),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => pickImage(ImageSource.camera),
                  child: Container(
                    width: 184.w(Get.context!),
                    height: 124.h(Get.context!),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: ColorStyle.primary500,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 30.t(Get.context!),
                          color: ColorStyle.primary500,
                        ),
                        SizedBox(
                          height: 10.h(Get.context!),
                        ),
                        AppText(
                          text: AppStrings.camera,
                          style: Styles.bodyLargeSemibold(
                            color: ColorStyle.primary500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.w(Get.context!),
                ),
                GestureDetector(
                  onTap: () => pickImage(ImageSource.gallery),
                  child: Container(
                    width: 184.w(Get.context!),
                    height: 124.h(Get.context!),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: ColorStyle.primary500,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo_library_outlined,
                          size: 30.t(Get.context!),
                          color: ColorStyle.primary500,
                        ),
                        SizedBox(
                          height: 10.h(Get.context!),
                        ),
                        AppText(
                          text: AppStrings.gallery,
                          style: Styles.bodyLargeSemibold(
                            color: ColorStyle.primary500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void signUp() async {
    if (page0Validation() && await page1Validation()) {
      EasyLoading.show();

      Map<String, dynamic> userDetails = {
        "name": nameController.text,
        "email": emailController.text,
        "username": usernameController.text,
        "gender": genders[selectedGender!],
        "profile_picture": profilePicture!.path,
        "password": generateMd5(passwordController.text),
      };
      User? user = await DatabaseHelper.createUser(data: userDetails);
      if (user != null) {
        Get.toNamed(
          Routes.EMAIL_VERIFICATION,
          arguments: {"route": Routes.HOME},
        );
      }
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
    if (profilePicture == null) {
      if (snackbar == true)
        showSnackbar(message: AppStrings.profilePictureValidation);
      return false;
    } else if (isEmptyString(nameController.text)) {
      if (snackbar == true) showSnackbar(message: AppStrings.nameValidation);
      return false;
    } else if (isEmptyString(usernameController.text) ||
        !(await DatabaseHelper.usernameAvailable(
            username: usernameController.text))) {
      if (snackbar == true) {
        showSnackbar(
            message:
                "${AppStrings.usernameIsEmpty} or ${AppStrings.usernameAlreadyExists}");
      }
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
