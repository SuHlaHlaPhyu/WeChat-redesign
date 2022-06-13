import 'package:flutter/material.dart';
import 'package:wechat_redesign/resources/dimens.dart';
class ProfileImageView extends StatelessWidget {
  const ProfileImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      backgroundImage: NetworkImage(
        "https://i.pinimg.com/736x/75/8f/57/758f57fe8f91f684be6059b632bee2c0.jpg",
      ),
      radius: MARGIN_XLARGE,
    );
  }
}