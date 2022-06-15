import 'package:flutter/material.dart';
import 'package:wechat_redesign/resources/dimens.dart';

class ProfileImageView extends StatelessWidget {
  final String? profile;
  const ProfileImageView({
    Key? key,
    required this.profile
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(
        profile ?? "",
      ),
      radius: MARGIN_XLARGE,
    );
  }
}