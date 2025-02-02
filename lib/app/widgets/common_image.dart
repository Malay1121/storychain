import 'package:flutter/cupertino.dart';
import 'package:storychain/app/helper/all_imports.dart';

class CommonImage extends StatefulWidget {
  CommonImage({
    required this.imageUrl,
    this.width,
    this.height,
    required this.fit,
    this.borderRadius,
    this.type = "network",
  });
  String imageUrl;
  double? width;
  double? height;
  BoxFit? fit;
  String type;
  BorderRadiusGeometry? borderRadius;

  @override
  State<CommonImage> createState() => _CommonImageState();
}

class _CommonImageState extends State<CommonImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
      child: widget.type == "network"
          ? CachedNetworkImage(
              imageUrl: widget.imageUrl,
              width: widget.width,
              height: widget.height,
              fit: widget.fit,
              progressIndicatorBuilder: (context, url, progress) =>
                  CircularProgressIndicator(
                color: ColorStyle.primary500,
              ),
              errorWidget: (context, url, error) => Icon(
                Icons.error_outline,
                color: ColorStyle.alertsStatusError,
              ),
            )
          : widget.type == "asset"
              ? Image.asset(
                  widget.imageUrl,
                  width: widget.width,
                  height: widget.height,
                  fit: widget.fit,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.error_outline,
                    color: ColorStyle.greyscale900,
                  ),
                )
              : widget.type == "file"
                  ? Image.file(
                      File(widget.imageUrl),
                      width: widget.width,
                      height: widget.height,
                      fit: widget.fit,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.error_outline,
                        color: ColorStyle.alertsStatusError,
                      ),
                    )
                  : SizedBox(),
    );
  }
}
