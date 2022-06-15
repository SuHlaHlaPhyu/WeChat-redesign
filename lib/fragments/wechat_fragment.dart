import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wechat_redesign/pages/chatting/conversation_page.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';

import '../viewitems/profile_image_view.dart';

class WeChatFragment extends StatelessWidget {
  const WeChatFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "WeChat",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: APP_TITLE_COLOR,
              fontSize: TEXT_REGULAR_2XX,
            ),
          ),
        ),
        backgroundColor: PRIMARY_COLOR,
        actions: const [
          Padding(
            padding: EdgeInsets.only(
              right: 10.0,
            ),
            child: Icon(
              Icons.add,
              size: 28.0,
              color: ADD_ICON_COLOR,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RecentConversationListSectionView(
              onTap: (index) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ConversationPage(
                    receiverId: "",
                  )),
                );
              },
            ),
            const DividerView(),
            const SubscriptionsSectionView(),
            const DividerView(),
            RecentConversationListSectionView(
              onTap: (index) {},
            )
          ],
        ),
      ),
    );
  }
}

class DividerView extends StatelessWidget {
  const DividerView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Divider(
          height: 3.0,
          thickness: 5.0,
        ),
        SizedBox(
          height: MARGIN_LARGE,
        ),
        Divider(
          height: 2.0,
        ),
      ],
    );
  }
}

class SubscriptionsSectionView extends StatelessWidget {
  const SubscriptionsSectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WECHAT_ITEM_BACKGROUND_COLOR,
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_2,
        vertical: MARGIN_MEDIUM,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Badge(
                badgeColor: PRIMARY_COLOR,
                shape: BadgeShape.circle,
                elevation: 0.0,
                toAnimate: false,
              ),
              const SizedBox(
                width: MARGIN_SMALL_2,
              ),
              Text(
                "SUBSCRIPTIONS",
                style: GoogleFonts.poppins(textStyle: const TextStyle(
                    color: SUBTEXT_COLOR,
                    fontWeight: FontWeight.bold,
                    fontSize: TEXT_REGULAR_2X)),
              ),
              const Spacer(),
              const Icon(
                Icons.keyboard_arrow_right,
                color: ICON_COLOR_BOLD,
              ),
            ],
          ),
          const SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(
                  Icons.tap_and_play_outlined,
                  size: MARGIN_XXLARGE,
                  color: ICON_COLOR,
                ),
              ),
              SubscriptionItem()
            ],
          )
        ],
      ),
    );
  }
}

class SubscriptionItem extends StatelessWidget {
  const SubscriptionItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children:[
              Text(
                "Tecent Official",
                style: GoogleFonts.poppins(textStyle: const TextStyle(
                    color: TEXT_COLOR_BOLD,
                    fontWeight: FontWeight.bold,
                    fontSize: TEXT_REGULAR_2X)),
              ),
             const Spacer(),
              Text(
                "12:10 PM",
                style: GoogleFonts.poppins(textStyle: const TextStyle(
                  color: SUBTEXT_TIME_COLOR,
                  fontSize: TEXT_SMALL,
                ),),
              )
            ],
          ),
          const SizedBox(
            height: MARGIN_SMALL,
          ),
          Text(
            "WeChat is now available in India.",
            style: GoogleFonts.poppins(textStyle:const  TextStyle(
              color: TEXT_COLOR_BOLD,
              fontSize: TEXT_SMALL,
            )),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            "I'm stuck with that. Can't believe it. Do we have to do with that stuck later?",
            style: GoogleFonts.poppins(textStyle: const  TextStyle(
              color: SUBTEXT_COLOR,
              fontSize: TEXT_SMALL,
            ),),
          )
        ],
      ),
    );
  }
}

class RecentConversationListSectionView extends StatelessWidget {
  final Function(int?) onTap;
  const RecentConversationListSectionView({Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return WechatSectionView(
          onTap: () {
            onTap(index);
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 1,
        );
      },
      itemCount: 4,
    );
  }
}

class WechatSectionView extends StatelessWidget {
  final Function onTap;
  const WechatSectionView({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        color: WECHAT_ITEM_BACKGROUND_COLOR,
        padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_2,
          vertical: MARGIN_MEDIUM,
        ),
        child: Row(
          children: [
            Visibility(
              visible: false,
              child: Container(
                color: PRIMARY_COLOR,
                width: MARGIN_MEDIUM,
                height: 75,
              ),
            ),
            const ProfileImageView(
              profile: "https://i.pinimg.com/736x/75/8f/57/758f57fe8f91f684be6059b632bee2c0.jpg",
            ),
            const SizedBox(
              width: MARGIN_MEDIUM,
            ),
            const WechatItem(),
          ],
        ),
      ),
    );
  }
}

class WechatItem extends StatelessWidget {
  const WechatItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                "Amie Deane",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: TEXT_COLOR_BOLD,
                    fontWeight: FontWeight.bold,
                    fontSize: TEXT_REGULAR_2X,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                "3:21 PM",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: SUBTEXT_TIME_COLOR,
                    fontSize: TEXT_SMALL,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: MARGIN_SMALL,
          ),
          Text(
            "I'm stuck with that. Can't believe it. Do we have to do with that stuck later?",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: SUBTEXT_COLOR,
                fontSize: TEXT_SMALL,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
