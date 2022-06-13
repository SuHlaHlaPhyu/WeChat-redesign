import 'package:flutter/material.dart';
import 'package:wechat_redesign/resources/dimens.dart';
class UserProfileView extends StatelessWidget {
  final String image;
  const UserProfileView({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(
        image,
      ),
      radius: USER_PROFILE_SIZE,
    );
  }
}