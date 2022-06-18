import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/blocs/chat_history_bloc.dart';
import 'package:wechat_redesign/data/vos/message_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/pages/chatting/conversation_page.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';

import '../viewitems/profile_image_view.dart';

class WeChatFragment extends StatelessWidget {
  const WeChatFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatHistoryBloc(),
      child: Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                    MaterialPageRoute(
                        builder: (context) => const ConversationPage(
                              receiverId: "",
                              receiverName: "",
                            )),
                  );
                },
              ),
              // const DividerView(),
              // const SubscriptionsSectionView(),
              // const DividerView(),
              // RecentConversationListSectionView(
              //   onTap: (index) {},
              // )
            ],
          ),
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
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
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
            children: [
              Text(
                "Tecent Official",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: TEXT_COLOR_BOLD,
                        fontWeight: FontWeight.bold,
                        fontSize: TEXT_REGULAR_2X)),
              ),
              const Spacer(),
              Text(
                "12:10 PM",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: SUBTEXT_TIME_COLOR,
                    fontSize: TEXT_SMALL,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: MARGIN_SMALL,
          ),
          Text(
            "WeChat is now available in India.",
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
              color: TEXT_COLOR_BOLD,
              fontSize: TEXT_SMALL,
            )),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            "I'm stuck with that. Can't believe it. Do we have to do with that stuck later?",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: SUBTEXT_COLOR,
                fontSize: TEXT_SMALL,
              ),
            ),
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

  void doNothing(BuildContext context) {}
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatHistoryBloc>(
      builder: (context, bloc, child) => ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  // An action can be bigger than the others.
                  flex: 3,
                  onPressed: doNothing,
                  backgroundColor: ME_BACKGROUND_COLOR,
                  foregroundColor: MILD_BLUE,
                  icon: Icons.check_circle,
                ),
                SlidableAction(
                  onPressed: doNothing,
                  backgroundColor: ME_BACKGROUND_COLOR,
                  foregroundColor: VIVID_RED,
                  icon: Icons.cancel,
                ),
              ],
            ),
            child: WechatSectionView(
              message: bloc.msgList[index],
              userVO: bloc.chatUser[index],
              onTap: () {
                onTap(index);
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
          );
        },
        itemCount: bloc.chatUser.length,
      ),
    );
  }
}

class WechatSectionView extends StatelessWidget {
  final UserVO? userVO;
  final List<MessageVO>? message;
  final Function onTap;
  const WechatSectionView({Key? key, required this.onTap,required this.userVO,required this.message}) : super(key: key);

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
            ProfileImageView(
              profile:
                  userVO?.profile ?? "",
            ),
            const SizedBox(
              width: MARGIN_MEDIUM,
            ),
            WechatItem(
              contact: userVO,
              message: message,
            ),
          ],
        ),
      ),
    );
  }
}

class WechatItem extends StatelessWidget {
  final UserVO? contact;
  final List<MessageVO>? message;
  const WechatItem({
    Key? key,
    required this.contact,
    required this.message
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
                contact?.name ?? "",
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
            message?.last.message ?? "",
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
