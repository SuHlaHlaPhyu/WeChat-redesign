import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/blocs/chat_history_bloc.dart';
import 'package:wechat_redesign/pages/chatting/conversation_page.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';
import 'package:wechat_redesign/viewitems/loading_view.dart';

import '../data/vos/chat_history_vo.dart';
import '../viewitems/profile_image_view.dart';

class WeChatFragment extends StatelessWidget {
  const WeChatFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatHistoryBloc(),
      child: Selector<ChatHistoryBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        shouldRebuild: (prev, next) => prev != next,
        builder: (context, isLoading, child) => Stack(
          children: [
            Scaffold(
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
                  children: const [
                    RecentConversationListSectionView(),
                    DividerView(),
                    SubscriptionsSectionView(),
                    DividerView(),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isLoading,
              child: Container(
                color: Colors.black12,
                child: const Center(
                  child: LoadingView(),
                ),
              ),
            ),
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
  const RecentConversationListSectionView({Key? key}) : super(key: key);

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
                // SlidableAction(
                //   // An action can be bigger than the others.
                //   flex: 3,
                //   onPressed: doNothing,
                //   backgroundColor: ME_BACKGROUND_COLOR,
                //   foregroundColor: MILD_BLUE,
                //   icon: Icons.check_circle,
                // ),
                SlidableAction(
                  onPressed: (context) {
                    bloc.onTapDeleteConversation(
                        bloc.result[index].chatContact?.qrCode ?? "");
                  },
                  backgroundColor: ME_BACKGROUND_COLOR,
                  foregroundColor: VIVID_RED,
                  icon: Icons.cancel,
                ),
              ],
            ),
            child: WechatSectionView(
              result: bloc.result[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConversationPage(
                      receiverId: bloc.result[index].chatContact?.qrCode,
                      receiverName: bloc.result[index].chatContact?.name,
                    ),
                  ),
                );
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
          );
        },
        itemCount: bloc.result.length,
      ),
    );
  }
}

class WechatSectionView extends StatelessWidget {
  final ChatHistoryVO result;
  final Function onTap;
  const WechatSectionView({Key? key, required this.onTap, required this.result})
      : super(key: key);

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
              profile: result.chatContact?.profile ?? "",
            ),
            const SizedBox(
              width: MARGIN_MEDIUM,
            ),
            WechatItem(
              history: result,
            ),
          ],
        ),
      ),
    );
  }
}

class WechatItem extends StatelessWidget {
  final ChatHistoryVO history;
  const WechatItem({Key? key, required this.history}) : super(key: key);

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
                history.chatContact?.name ?? "",
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
            history.lastMessage ?? "",
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
