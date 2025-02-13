import 'package:storychain/app/helper/all_imports.dart';

class CommonPost extends StatefulWidget {
  CommonPost({
    required this.story,
    required this.title,
    this.lastSentence,
    required this.contributorsCount,
    required this.liveNowCount,
    required this.liveLimitCount,
    required this.likesCount,
    required this.commentsCount,
    required this.maxSentences,
    required this.profileModel,
    required this.sentenceCount,
    required this.createdAt,
  });
  Map story;
  String title;
  Map? lastSentence;
  int contributorsCount;
  int liveNowCount;
  int liveLimitCount;
  int likesCount;
  int commentsCount;
  int maxSentences;
  ProfileModel profileModel;
  int sentenceCount;
  String createdAt;

  @override
  State<CommonPost> createState() => _CommonPostState();
}

class _CommonPostState extends State<CommonPost> {
  bool liked = false;
  void checkLike() async {
    liked = await DatabaseHelper.storyLiked(
        uid: getKey(userDetails, ["uid"], ""),
        storyId: getKey(widget.story, ["id"], ""));
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLike();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380.w(context),
      padding: EdgeInsets.symmetric(
        vertical: 24.h(context),
        horizontal: 24.h(context),
      ),
      margin: EdgeInsets.only(bottom: 24.h(context)),
      decoration: BoxDecoration(
        color: ColorStyle.greyscale50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Get.toNamed(Routes.USER_PROFILE, arguments: {
                  "userId": widget.profileModel.uid,
                }),
                child: Row(
                  children: [
                    CommonImage(
                      imageUrl: "${widget.profileModel.profilePicture}",
                      fit: BoxFit.cover,
                      height: 30.h(context),
                      width: 30.h(context),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    SizedBox(
                      width: 10.w(context),
                    ),
                    SizedBox(
                      height: 30.h(context),
                      child: Center(
                        child: AppText(
                          text: widget.profileModel.name,
                          style: Styles.bodyMediumSemibold(
                            color: ColorStyle.greyscale500,
                          ),
                          minFontSize: 14.t(context).toInt().toDouble(),
                          // height: 30.h(context),
                          width: 130.w(context),
                          // centered: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 24.w(context),
              ),
              Spacer(),
              if (widget.profileModel.uid != getKey(userDetails, ["uid"], ""))
                CommonButton(
                  width: 73.w(context),
                  height: 30.h(context),
                  enabled: false,
                  text: AppStrings.follow,
                  backgroundColor: ColorStyle.primary500,
                  onTap: () {},
                ),
              if (widget.profileModel.uid != getKey(userDetails, ["uid"], ""))
                SizedBox(
                  width: 10.w(context),
                ),
              Icon(
                Icons.more_vert,
                color: ColorStyle.greyscale900,
                size: 30.t(context),
              ),
            ],
          ),
          SizedBox(
            height: 16.h(context),
          ),
          Container(
            width: 332.w(context),
            height: 1,
            color: ColorStyle.greyscale200,
          ),
          SizedBox(
            height: 16.h(context),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 240.w(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppText(
                      text: widget.title,
                      maxLines: null,
                      style: Styles.bodyLargeBold(
                        color: ColorStyle.greyscale900,
                      ),
                    ),
                    SizedBox(
                      height: 10.h(context),
                    ),
                    AppText(
                      text: getKey(widget.lastSentence ?? {}, ["sentence"],
                          AppStrings.thereAreNoSentencesToDisplay),
                      maxLines: null,
                      style: Styles.bodyMediumSemibold(
                        color: widget.lastSentence == null
                            ? ColorStyle.alertsStatusError
                            : ColorStyle.greyscale700,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  AppText(
                    text: AppStrings.sentences,
                    style: Styles.bodyMediumRegular(
                      color: ColorStyle.greyscale900,
                    ),
                  ),
                  AppText(
                    text: "${widget.sentenceCount}/${widget.maxSentences}",
                    style: Styles.h2Bold(
                      color: ColorStyle.primary500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 24.h(context),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 110.w(context),
                child: Column(
                  children: [
                    AppText(
                      text: AppStrings.contributors,
                      style: Styles.bodyMediumRegular(
                        color: ColorStyle.greyscale900,
                      ),
                    ),
                    AppText(
                      text: "${widget.contributorsCount}",
                      style: Styles.h3Bold(
                        color: ColorStyle.othersPurple,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 60.h(context),
                width: 1,
                color: ColorStyle.greyscale200,
              ),
              SizedBox(
                width: 110.w(context),
                child: Column(
                  children: [
                    AppText(
                      text: AppStrings.liveNow,
                      style: Styles.bodyMediumRegular(
                        color: ColorStyle.greyscale900,
                      ),
                    ),
                    AppText(
                      text: "${widget.liveNowCount}",
                      style: Styles.h3Bold(
                        color: ColorStyle.greyscale900,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 60.h(context),
                width: 1,
                color: ColorStyle.greyscale200,
              ),
              SizedBox(
                width: 110.w(context),
                child: Column(
                  children: [
                    AppText(
                      text: AppStrings.liveLimit,
                      style: Styles.bodyMediumRegular(
                        color: ColorStyle.greyscale900,
                      ),
                    ),
                    AppText(
                      text: "${widget.liveLimitCount}",
                      style: Styles.h3Bold(
                        color: ColorStyle.secondary500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24.h(context),
          ),
          CommonButton(
            text: AppStrings.contribute,
            onTap: () => Get.toNamed(
              Routes.CONTRIBUTE,
              arguments: {
                "story_id": getKey(widget.story, ["id"], null),
              },
            ),
            width: 332.w(context),
            height: 58.h(context),
          ),
          SizedBox(
            height: 32.h(context),
          ),
          Row(
            children: [
              AppText(
                text: "${formatDateTime(fromUtc(widget.createdAt))}",
                style: Styles.bodySmallSemibold(color: ColorStyle.greyscale500),
              ),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  if (await DatabaseHelper.storyLiked(
                      uid: getKey(userDetails, ["uid"], ""),
                      storyId: getKey(widget.story, ["id"], ""))) {
                    widget.likesCount--;
                  } else {
                    widget.likesCount++;
                  }
                  setState(() {});
                  await DatabaseHelper.likeStory(
                      uid: getKey(userDetails, ["uid"], ""),
                      storyId: getKey(widget.story, ["id"], ""));
                  checkLike();
                },
                child: Icon(
                  liked ? Icons.favorite : Icons.favorite_border,
                  size: 24.h(context),
                  color: liked ? ColorStyle.othersRed : ColorStyle.greyscale900,
                ),
              ),
              SizedBox(
                width: 8.w(context),
              ),
              AppText(
                text: "${widget.likesCount}",
                style: Styles.bodySmallSemibold(color: ColorStyle.greyscale900),
              ),
              SizedBox(
                width: 24.w(context),
              ),
              Icon(
                Icons.mode_comment_outlined,
                size: 24.h(context),
                color: ColorStyle.greyscale900,
              ),
              SizedBox(
                width: 8.w(context),
              ),
              AppText(
                text: "${widget.commentsCount}",
                style: Styles.bodySmallSemibold(color: ColorStyle.greyscale900),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileModel {
  ProfileModel({
    required this.uid,
    required this.name,
    required this.username,
    required this.profilePicture,
    required this.email,
  });
  String name;
  String username;
  String profilePicture;
  String email;
  String uid;
}
