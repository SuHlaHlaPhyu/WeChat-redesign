import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import 'package:wechat_redesign/blocs/moments_bloc.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/pages/create_post_page.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';
import 'package:wechat_redesign/viewitems/moment_overlay.dart';

import '../viewitems/user_profile_and_name_section_view.dart';


class DiscoverFragment extends StatefulWidget {
  const DiscoverFragment({Key? key}) : super(key: key);
  @override
  State<DiscoverFragment> createState() => _DiscoverFragmentState();
}

class _DiscoverFragmentState extends State<DiscoverFragment> {
  MomentsBloc? bloc;
  @override
  void initState() {
    bloc = MomentsBloc();
    super.initState();
  }

  @override
  void dispose() {
    bloc?.flickManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      child: Selector<MomentsBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, moments, child) => Scaffold(
          backgroundColor: BACKGROUND_COLOR,
          appBar: AppBar(
            backgroundColor: PRIMARY_COLOR,
            elevation: 0.0,
            actions: [
              Expanded(
                child: Row(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const  Padding(
                          padding: EdgeInsets.only(
                            left: 10.0,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 28.0,
                            color: ADD_ICON_COLOR,
                          ),
                        ),
                        Text(
                          "Discover",
                          style: GoogleFonts.poppins(textStyle:const  TextStyle(
                            color: Color.fromRGBO(171, 239, 183, 1),
                            fontSize: TEXT_REGULAR_2XX,
                          )),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      "Moments",
                      style: GoogleFonts.poppins(textStyle:const  TextStyle(
                        fontWeight: FontWeight.w600,
                        color: APP_TITLE_COLOR,
                        fontSize: TEXT_REGULAR_2XX,
                      )),
                    ),
                    const Spacer(),
                    const Spacer(),
                    CreatePostIcon(
                      onTap: () {
                        /// navigate to create post
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreatePostPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const HeaderSectionView(),
                MomentItemListSectionView(
                  onTap: (item) {
                    Overlay.of(context)?.insert(_getEntry(context, item));
                  },
                  onTapComment: () {
                    Overlay.of(context)?.insert(_getCommentEntry(context));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  OverlayEntry _getEntry(context, MomentVO? item) {
    OverlayEntry? entry;

    entry = OverlayEntry(
      opaque: false,
      maintainState: true,
      builder: (_) => Positioned(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 10.0,
            sigmaY: 10.0,
          ),
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              color: Colors.transparent.withOpacity(0.8),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    OverlayMoment(
                      moment: item,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        entry?.remove();
                      },
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 50.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    return entry;
  }

  OverlayEntry _getCommentEntry(context) {
    OverlayEntry? entry;

    entry = OverlayEntry(
      opaque: false,
      maintainState: true,
      builder: (_) => Positioned(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 10.0,
            sigmaY: 10.0,
          ),
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              color: Colors.transparent.withOpacity(0.8),
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        //controller: TextEditingController(text: ""),
                        onChanged: (text) {},
                        decoration: const InputDecoration(
                          hintText: "Comment here...",
                          hintStyle: TextStyle(color: Colors.white),
                          suffixIcon: Icon(Icons.tag_faces_rounded),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          entry?.remove();
                        },
                        child: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 50.0,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    return entry;
  }
}

class CreatePostIcon extends StatelessWidget {
  final Function onTap;
  const CreatePostIcon({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: const Padding(
        padding: EdgeInsets.only(
          right: 10.0,
        ),
        child: Icon(
          Icons.photo_camera_back_outlined,
          size: 28.0,
          color: ADD_ICON_COLOR,
        ),
      ),
    );
  }
}

class MomentItemListSectionView extends StatelessWidget {
  final Function(MomentVO?) onTap;
  final Function onTapComment;
  const MomentItemListSectionView({
    Key? key,
    required this.onTap,
    required this.onTapComment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MomentsBloc>(
      builder: (context, bloc, child) => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: bloc.moments?.length ?? 0,
        itemBuilder: (context, index) {
          return MomentItem(
            onTap: () {
              onTap(bloc.moments?[index]);
            },
            onTapComment: () {
              onTapComment();
            },
            moment: bloc.moments?[index],
          );
        },
      ),
    );
  }
}

class MomentItem extends StatelessWidget {
  final MomentVO? moment;
  final Function onTap;
  final Function onTapComment;
  const MomentItem({
    Key? key,
    required this.onTap,
    required this.moment,
    required this.onTapComment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        // height: MOMENT_CONTAINER_HEIGHT,
        height: null,
        child: Stack(
          children: [
            Column(
              children: [
                PostedTimeView(
                  time: moment?.id.toString(),
                ),
                const Divider(
                  height: 1.0,
                  thickness: 1.0,
                ),
                MomentByOthersSectionView(
                  momentVO: moment,
                  onTap: () {
                    onTapComment();
                  },
                ),
                const Divider(
                  height: 7.0,
                  thickness: 7.0,
                ),
                const LikeCommentByOtherSectionView(),
              ],
            ),
            const Positioned(
              top: 17.0,
              left: 30.0,
              child: UserProfileAndNameSectionView(
                profile:
                    "https://bestprofilepictures.com/wp-content/uploads/2021/08/Anime-Girl-Profile-Picture.jpg",
                name: " Su Hla Phyu",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostedTimeView extends StatelessWidget {
  final String? time;
  const PostedTimeView({
    Key? key,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            " 3 mins ago",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: SUBTEXT_TIME_COLOR,
                fontSize: TEXT_REGULAR,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MomentByOthersSectionView extends StatelessWidget {
  final MomentVO? momentVO;
  final Function onTap;
  const MomentByOthersSectionView({
    Key? key,
    required this.momentVO,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MOMENT_INFO_HIGHT,
      height: null,
      width: double.infinity,
      color: BACKGROUND_WHITE_COLOR,
      //color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 0.0,
          right: 0.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 40.0,
            ),
            MomentInfoView(
              moment: momentVO,
            ),
            const SizedBox(
              height: 10.0,
            ),
            LikeCommentSectionView(
              id: momentVO?.id ?? 0,
              onTapComment: () {
                onTap();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LikeCommentByOtherSectionView extends StatelessWidget {
  const LikeCommentByOtherSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 50.0,
        right: 12.0,
        bottom: 12.0,
      ),
      child: Column(
        children: const [
          SizedBox(
            height: 10.0,
          ),
          LikeByOthersView(),
          SizedBox(
            height: 10.0,
          ),
          CommentByOthersView(),
        ],
      ),
    );
  }
}

class CommentByOthersView extends StatelessWidget {
  const CommentByOthersView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.messenger,
          size: 13.0,
          color: Color.fromRGBO(74, 74, 74, 1),
        ),
        const SizedBox(
          width: 4.0,
        ),
        Container(
          width: 250.0,
          child: Row(
            children: [
              Text(
                "Anna",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: TEXT_COLOR_BOLD,
                    fontWeight: FontWeight.w500,
                    fontSize: 11.5,
                  ),
                ),
              ),
              Text(
                "I have read all his books.",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 11.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LikeByOthersView extends StatelessWidget {
  const LikeByOthersView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.favorite,
          size: 15.0,
          color: Color.fromRGBO(74, 74, 74, 1),
        ),
        const SizedBox(
          width: 4.0,
        ),
        Container(
          width: 250.0,
          child: Text(
            "Nuno Rocha, Annie Deane, Alan Lu, Sam Deane, Ale Aunoz",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: TEXT_COLOR_BOLD,
                fontWeight: FontWeight.w500,
                fontSize: 11.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MomentInfoView extends StatelessWidget {
  final MomentVO? moment;
  const MomentInfoView({Key? key, required this.moment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 12.0),
          child: Text(
            "${moment?.description}",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: MOMENT_SUBTEXT_COLOR,
                fontSize: TEXT_SMALL,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        moment?.isVideo == false
            ? moment?.postFile == "" || moment?.postFile == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 15.0),
                    child: Image.network("${moment?.postFile}"),
                  )
            : Consumer<MomentsBloc>(
                builder: (context, bloc, child) => Container(
                  margin: const EdgeInsets.only(
                      left: 8.0, right: 8.0, bottom: 15.0),
                  child: FlickVideoPlayer(
                    flickManager:
                        bloc.playVideo("${moment?.postFile.toString()}")!,
                    flickVideoWithControls: const FlickVideoWithControls(
                      closedCaptionTextStyle: TextStyle(
                        fontSize: 8,
                      ),
                      controls: FlickPortraitControls(),
                    ),
                    flickVideoWithControlsFullscreen:
                        const FlickVideoWithControls(
                      controls: FlickLandscapeControls(),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}

class LikeCommentSectionView extends StatelessWidget {
  final int id;
  final Function onTapComment;
  const LikeCommentSectionView({
    Key? key,
    required this.id,
    required this.onTapComment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MomentsBloc>(
      builder: (context, bloc, child) => Padding(
        padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
        child: Row(
          children: [
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.favorite_outlined,
                  color: VIVID_RED,
                  size: 25.0,
                ),
                const SizedBox(
                  width: 7.0,
                ),
                GestureDetector(
                  onTap: () {
                    ///
                    onTapComment();
                  },
                  child: const Icon(
                    Icons.messenger_outline_outlined,
                    color: ICON_COLOR,
                    size: 25.0,
                  ),
                ),
                MoreButtonView(
                  onTapDelete: () {
                    bloc.onTapDeletePost(id);
                  },
                  onTapEdit: () {
                    Future.delayed(const Duration(milliseconds: 1000))
                        .then((value) {
                      _navigateToEditPostPage(context, id);
                    });
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToEditPostPage(BuildContext context, int momentId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreatePostPage(
          momentId: momentId,
        ),
      ),
    );
  }
}

class MoreButtonView extends StatelessWidget {
  final Function onTapDelete;
  final Function onTapEdit;

  const MoreButtonView({
    Key? key,
    required this.onTapDelete,
    required this.onTapEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      icon: const Icon(
        Icons.more_horiz_outlined,
        color: Colors.grey,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            onTapEdit();
          },
          child: Text(
            "Edit",
            style: GoogleFonts.poppins(),
          ),
          value: 1,
        ),
        PopupMenuItem(
          onTap: () {
            onTapDelete();
          },
          child: Text(
            "Delete",
            style: GoogleFonts.poppins(),
          ),
          value: 2,
        )
      ],
    );
  }
}

class HeaderSectionView extends StatelessWidget {
  const HeaderSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      child: Stack(
        children: [
          Column(
            children: const [
              CoverPhotoAndNameView(),
              Divider(
                height: 7.0,
                thickness: 7.0,
              ),
              AccountInfoView()
            ],
          ),
          const Positioned(
            top: 170.0,
            left: 80.0,
            child: ProfileImageView(),
          ),
        ],
      ),
    );
  }
}

class AccountInfoView extends StatelessWidget {
  const AccountInfoView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          const Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Sunday, Sept 14, 2015",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(fontWeight: FontWeight.w500)),
              ),
              Text(
                "23 new moments",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CoverPhotoAndNameView extends StatelessWidget {
  const CoverPhotoAndNameView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.0,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://wallpapers.com/images/high/small-baby-pink-flower-5748ltauzi5n35vt.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Nina Rocha",
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_3X,
              fontWeight: FontWeight.w400,
            )),
          ),
        ),
      ),
    );
  }
}

class ProfileImageView extends StatelessWidget {
  const ProfileImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: PROFILE_MOMENT_BORDER_SIZE,
      backgroundColor: SUBTEXT_COLOR,
      child: CircleAvatar(
        backgroundImage: NetworkImage(
          "https://i.pinimg.com/originals/e2/01/68/e20168a4340f439462017456d2e0b8d2.jpg",
        ),
        radius: PROFILE_MOMENT_SIZE,
      ),
    );
  }
}
