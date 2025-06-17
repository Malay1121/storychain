import 'package:get/get.dart';

import '../../../helper/all_imports.dart';

class EditProfileController extends CommonController {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  List genders = [AppStrings.male, AppStrings.female, AppStrings.other];
  int? selectedGender;
  Map? userInfo = {};

  File? profilePicture;
  String? networkPicture;


  @override
  void onInit() {
    super.onInit();
    getUserDetails();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void selectGender(String gender) {
    selectedGender = genders.indexOf(gender);
    update();
  }

  bool isGenderSelected(String gender) {
    return genders.indexOf(gender) == selectedGender;
  }

  int page = 0;
  int maxPage = 1;

  void getUserDetails() async{
    userInfo = await DatabaseHelper.getUser(userId: user?.uid ?? "");
    if (userInfo != null && userInfo != {}) {
      String gender = getKey(userInfo!, ["gender"], "").toString().toLowerCase();
      nameController.text = getKey(userInfo!, ["name"], "");
      usernameController.text = getKey(userInfo!, ["username"], "");
      networkPicture = getKey(userInfo!, ["profile_picture"], "");
      selectedGender = gender == "male" ? 0 : gender == "female" ? 1 : gender == "other" ? 2 : null;
      update();
    }

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

  void editProfile() async {
    if ( await page1Validation()) {
      EasyLoading.show();

      Map<String, dynamic> details = {"name": nameController.text,
        // "email": emailController.text,
        "username": usernameController.text,
        "gender": genders[selectedGender!],
        "profile_picture": profilePicture ?? networkPicture,};

      Map<String, dynamic> ud = {};
      for (String key in details.keys) {
        if (details[key] != userInfo?[key]) {
          ud.addEntries({key: details[key]}.entries);
        }
      }

      User? u = await DatabaseHelper.editUser(userId: user?.uid ?? "", data: ud);
      if (u != null) {
        Get.back();
      }
      EasyLoading.dismiss();
    }
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
            username: usernameController.text) || getKey(userInfo ?? {}, ["username"], "") == usernameController.text)) {
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

}
