import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_redesign/blocs/chatting_bloc.dart';
import 'package:wechat_redesign/data/vos/message_vo.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';
import 'package:wechat_redesign/viewitems/loading_view.dart';
import 'package:wechat_redesign/viewitems/sender_profile_view.dart';

class ConversationPage extends StatefulWidget {
  final String? receiverId;
  const ConversationPage({Key? key, required this.receiverId})
      : super(key: key);
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConversationBloc(widget.receiverId),
      child: Selector<ConversationBloc, bool>(
        selector: (context,bloc) => bloc.isLoading,
        builder: (context,isLoading,child)=>
         Stack(
           children: [
             Scaffold(
              backgroundColor: BACKGROUND_WHITE_COLOR,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0.0,
                backgroundColor: PRIMARY_COLOR,
                actions: [
                  Expanded(
                    child: Row(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(
                                  left: 10.0,
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 28.0,
                                  color: ADD_ICON_COLOR,
                                ),
                              ),
                            ),
                            Text(
                              "Wechat",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(171, 239, 183, 1),
                                  fontSize: TEXT_REGULAR_2XX,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          "Amie Deane",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: APP_TITLE_COLOR,
                              fontSize: TEXT_REGULAR_2XX,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(
                            right: 10.0,
                          ),
                          child: Icon(
                            Icons.person_outline,
                            size: 28.0,
                            color: ADD_ICON_COLOR,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  const Expanded(
                    child: ConversationListSectionView(),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const ChosenFileView(),
                      MessageComposerView(
                        onTapAdd: () {
                          setState(() {
                            isShow = !isShow;
                          });
                        },
                        isClose: isShow,
                      ),
                      Visibility(
                        visible: isShow,
                        child: const CategoryIconSectionView(),
                      ),
                    ],
                  ),
                ],
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

class ConversationListSectionView extends StatefulWidget {
  const ConversationListSectionView({Key? key}) : super(key: key);

  @override
  State<ConversationListSectionView> createState() =>
      _ConversationListSectionViewState();
}

class _ConversationListSectionViewState
    extends State<ConversationListSectionView> {
  _buildMessage(MessageVO? message, bool isMe) {
    final Container textMessage =
        (message?.message == "" || message?.message == null)
            ? Container()
            : Container(
                margin: isMe
                    ? const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                        left: 130.0,
                      )
                    : const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                      ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 10.0,
                ),
                width: MediaQuery.of(context).size.width * 0.55,
                decoration: BoxDecoration(
                  color: CHAT_TEXT_BACKGROUND_COLOR,
                  borderRadius: BorderRadius.circular(
                    40.0,
                  ),
                ),
                child: Text(
                  message?.message ?? "",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: TEXT_COLOR_BOLD,
                      fontSize: TEXT_REGULAR,
                    ),
                  ),
                ),
              );
    final Container fileMessage = (message?.file == "" || message?.file == null)
        ? Container()
        : Container(
            margin: isMe
                ? const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    left: 130.0,
                  )
                : const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                  ),
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 10.0,
            ),
            width: MediaQuery.of(context).size.width * 0.65,
            child: (message?.isVideo == false)
                ? Image.network("${message?.file}")
                : FlickVideoPlayer(
                    flickManager: FlickManager(
                      videoPlayerController: VideoPlayerController.network(
                        message?.file ?? "",
                      ),
                      autoPlay: false,
                    ),
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
          );
    if (isMe) {
      return Column(
        children: [
          textMessage,
          fileMessage,
        ],
      );
    }
    return Row(
      children: <Widget>[
        SenderProfileView(
          profile: message?.profilePic,
        ),
        const SizedBox(
          width: 3.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textMessage,
            fileMessage,
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConversationBloc>(
      builder: (context, bloc, child) => ListView.builder(
        reverse: true,
        padding: const EdgeInsets.only(top: 15.0),
        itemCount: bloc.conversationList?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          final MessageVO? message = bloc.conversationList?[index];
          final bool isMe = message?.userId == bloc.loginUser?.qrCode;
          return _buildMessage(message, isMe);
        },
      ),
    );
  }
}

class MessageComposerView extends StatefulWidget {
  final Function onTapAdd;
  final bool isClose;
  const MessageComposerView(
      {Key? key, required this.onTapAdd, required this.isClose})
      : super(key: key);

  @override
  State<MessageComposerView> createState() => _MessageComposerViewState();
}

class _MessageComposerViewState extends State<MessageComposerView> {
  TextEditingController controller = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Consumer<ConversationBloc>(
      builder: (context, bloc, child) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 5.0,
        ),
        height: 55.0,
        decoration: BoxDecoration(
          color: MSG_COMPOSER_BACKGROUND_COLOR,
          border: Border.all(
            color: DIVIDER_COLOR,
          ),
        ),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.mic_none_outlined,
              ),
              iconSize: 30.0,
              color: MSG_COMPOSER_ICON_COLOR,
              onPressed: () {},
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                decoration: BoxDecoration(
                  color: MSG_COMPOSER_TEXTFEID_BACKGROUND_COLOR,
                  border: Border.all(
                    color: DIVIDER_COLOR,
                  ),
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                ),
                child: TextField(
                  controller: controller,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (value) {
                    bloc.onChangeMessage(value);
                  },
                  onSubmitted: (value) {
                    bloc.sendMessage(value);
                    controller.clear();
                   // bloc.onTapDeleteImage();
                  },
                  decoration: const InputDecoration(
                    hintText: 'Message ...',
                    hintStyle: TextStyle(
                      color: ICON_COLOR,
                    ),
                    border: InputBorder.none,
                    suffixIcon: Icon(
                      Icons.tag_faces_rounded,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: widget.isClose
                  ? const Icon(Icons.close)
                  : const Icon(Icons.add),
              iconSize: 30.0,
              color: MSG_COMPOSER_ICON_COLOR,
              onPressed: () {
                widget.onTapAdd();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryIconSectionView extends StatelessWidget {
  const CategoryIconSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ConversationBloc>(
      builder: (context, bloc, child) => Container(
        height: 200.0,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        color: MSG_COMPOSER_CATEGORY_COLOR,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      bloc.onFileChosen(result?.files.first);
                    },
                    child: const IconAndTitle(
                      icon: Icons.photo_outlined,
                      title: "Files",
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      ImagePicker()
                          .pickImage(source: ImageSource.camera)
                          .then((value) async {
                        var bytes = await value?.readAsBytes();
                        bloc.onImageChosen(
                            File(value?.path ?? ""), bytes ?? Uint8List(0));
                      }).catchError((error) {
                        print("error");
                      });
                    },
                    child: const IconAndTitle(
                      icon: Icons.camera_alt_outlined,
                      title: "Camera",
                    ),
                  ),
                  const Spacer(),
                  const IconAndTitle(
                    icon: Icons.filter_center_focus_outlined,
                    title: "Sight",
                  ),
                  const Spacer(),
                  const IconAndTitle(
                    icon: Icons.videocam_outlined,
                    title: "Video Call",
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  IconAndTitle(
                    icon: Icons.markunread_mailbox_outlined,
                    title: "Luck Money",
                  ),
                  Spacer(),
                  IconAndTitle(
                    icon: Icons.swap_horiz_outlined,
                    title: "Transfer",
                  ),
                  Spacer(),
                  IconAndTitle(
                    icon: Icons.favorite_outline,
                    title: "Favorites",
                  ),
                  Spacer(),
                  IconAndTitle(
                    icon: Icons.pin_drop_outlined,
                    title: "Location",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChosenFileView extends StatelessWidget {
  const ChosenFileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ConversationBloc>(
        builder: (context, bloc, child) => bloc.isFromCamera == true
            ? Container(
                color: MSG_COMPOSER_CATEGORY_COLOR,
                padding: const EdgeInsets.only(
                    right: MARGIN_LARGE,
                    top: MARGIN_SMALL,
                    bottom: MARGIN_SMALL),
                height: ADD_NEW_POST_TEXTFIELD_HEIGHT,
                child: Stack(
                  children: [
                    Image.file(
                      bloc.chosenImage ?? File("path"),
                      height: 300,
                      width: 300,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Visibility(
                        visible: bloc.chosenImage != null,
                        child: GestureDetector(
                          onTap: () {
                            bloc.onTapDeleteImage();
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Visibility(
                visible: bloc.chosenFile != null,
                child: bloc.chosenFile?.extension != "mp4"
                    ? Container(
                        color: MSG_COMPOSER_CATEGORY_COLOR,
                        padding: const EdgeInsets.only(
                            left: MARGIN_XXXLARGE,
                            right: MARGIN_LARGE,
                            top: MARGIN_SMALL,
                            bottom: MARGIN_SMALL),
                        height: ADD_NEW_POST_TEXTFIELD_HEIGHT,
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 300,
                              child: Image.file(
                                File(bloc.chosenFile?.path.toString() ?? ""),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Visibility(
                                visible: bloc.chosenFile != null,
                                child: GestureDetector(
                                  onTap: () {
                                    bloc.onTapDeleteImage();
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Stack(
                        children: [
                          Container(
                            color: MSG_COMPOSER_CATEGORY_COLOR,
                            padding: const EdgeInsets.only(
                                left: MARGIN_XXXLARGE,
                                right: MARGIN_XLARGE,
                                top: MARGIN_XLARGE,
                                bottom: MARGIN_SMALL),
                            height: ADD_NEW_POST_TEXTFIELD_HEIGHT,
                            child: FlickVideoPlayer(
                              flickManager: FlickManager(
                                videoPlayerController:
                                    VideoPlayerController.network(
                                  "${bloc.chosenFile?.path.toString()}",
                                ),
                              ),
                              flickVideoWithControls:
                                  const FlickVideoWithControls(
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
                          Align(
                            alignment: Alignment.topRight,
                            child: Visibility(
                              visible: bloc.chosenFile != null,
                              child: GestureDetector(
                                onTap: () {
                                  bloc.onTapDeleteImage();
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ));
  }
}

class IconAndTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  const IconAndTitle({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: MSG_COMPOSER_ICONS_COLOR,
            size: 35.0,
          ),
          const SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: SUBTEXT_COLOR,
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
