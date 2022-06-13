import 'package:flutter/material.dart';
import 'package:wechat_redesign/resources/dimens.dart';
class SenderProfileView extends StatelessWidget {
  const SenderProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      backgroundImage: NetworkImage(
        "https://www.teahub.io/photos/full/298-2981503_cute-girls-for-fb-profile-dp-cute-best.jpg",
      ),
      radius: SENDER_PROFILE_SIZE,
    );
  }
}