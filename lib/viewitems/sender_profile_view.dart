import 'package:flutter/material.dart';
import 'package:wechat_redesign/resources/dimens.dart';
class SenderProfileView extends StatelessWidget {
  final String? profile;
  const SenderProfileView({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(
        profile ?? "",
      ),
      radius: SENDER_PROFILE_SIZE,
    );
  }
}