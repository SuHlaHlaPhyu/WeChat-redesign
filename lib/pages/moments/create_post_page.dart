import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_redesign/blocs/create_post_bloc.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';
import 'package:wechat_redesign/viewitems/loading_view.dart';
import 'package:wechat_redesign/viewitems/user_profile_and_name_section_view.dart';

class CreatePostPage extends StatefulWidget {
  final int? momentId;
  const CreatePostPage({Key? key, this.momentId}) : super(key: key);
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  CreatePostBloc? bloc;
  @override
  void initState() {
    bloc = CreatePostBloc(id: widget.momentId);
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
      child: Selector<CreatePostBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, isLoading, child) => Stack(
          children: [
            Consumer<CreatePostBloc>(
              builder: (context, bloc, chile) => Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: BACKGROUND_COLOR,
                appBar: AppBar(
                  elevation: 0.0,
                  title: const Text(
                    "Create Post",
                    style: TextStyle(
                      color: APP_TITLE_COLOR,
                      fontSize: TEXT_REGULAR_2XX,
                    ),
                  ),
                  backgroundColor: PRIMARY_COLOR,
                  actions: [
                    GestureDetector(
                      onTap: () {
                        bloc
                            .onTapAddNewMoment()
                            .then((value) => Navigator.pop(context));
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(
                          right: 13.0,
                        ),
                        child: Center(
                          child: Text(
                            "Post",
                            style: TextStyle(
                              color: APP_TITLE_COLOR,
                              fontSize: TEXT_REGULAR,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                body: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 12.0,
                          top: 12.0,
                          right: 12.0,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            UserProfileAndNameSectionView(
                              isMe: true,
                              profile: bloc.loginUser?.profile ?? "",
                              name: bloc.loginUser?.name ?? "",
                            ),
                            const SizedBox(
                              height: MARGIN_SMALL_2,
                            ),
                            const AddNewPostTextFieldView(),
                            const ChosenFileView()
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 10.0,
                      child: CategoryListSectionView(),
                    ),
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
            )
          ],
        ),
      ),
    );
  }
}

class CategoryListSectionView extends StatelessWidget {
  const CategoryListSectionView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<CreatePostBloc>(
      builder: (context, bloc, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              bloc.setFlag();
            },
            child: bloc.down ? const Icon(
              Icons.keyboard_arrow_down_sharp,
            ) : const Icon(
              Icons.keyboard_arrow_up_sharp,
            ),
          ),
          GestureDetector(
            onTap: () async {
              FilePickerResult? result =
              await FilePicker.platform.pickFiles();
              bloc.onFileChosen(result?.files.first);
            },
            child: const IconNameRowView(
              icon: Icons.photo_library,
              name: "Photo/video",
              color: PRIMARY_COLOR,
            ),
          ),
          Visibility(
            visible: bloc.down ,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                GestureDetector(
                  onTap: () {},
                  child: const IconNameRowView(
                    icon: Icons.person_add_alt_1,
                    name: "Tag people",
                    color: Colors.blueAccent,
                  ),
                ),
                const IconNameRowView(
                  icon: Icons.tag_faces_outlined,
                  name: "Feeling/Activity",
                  color: Colors.orange,
                ),
                const IconNameRowView(
                  icon: Icons.location_on,
                  name: "Check in",
                  color: Colors.deepOrange,
                ),
                const IconNameRowView(
                  icon: Icons.videocam_outlined,
                  name: "Live video",
                  color: Colors.red,
                ),
                const IconNameRowView(
                  icon: Icons.camera_alt,
                  name: "Camera",
                  color: Colors.blue,
                ),
                const IconNameRowView(
                  icon: Icons.text_fields,
                  name: "Background colour",
                  color: Colors.cyan,
                ),
                const IconNameRowView(
                  icon: Icons.mic,
                  name: "Host a Q&A",
                  color: Colors.deepPurpleAccent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChosenFileView extends StatelessWidget {
  const ChosenFileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CreatePostBloc>(
      builder: (context, bloc, child) => bloc.isEditMode && bloc.isRemove
          ? (bloc.chosenFile != null)
              ? Visibility(
                  visible: bloc.chosenFile != null,
                  child: bloc.chosenFile?.extension != "mp4"
                      ? Container(
                          padding: const EdgeInsets.all(MARGIN_MEDIUM),
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
                              child: FlickVideoPlayer(
                                flickManager: bloc.flickManager!,
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
                )
              : Visibility(
                  visible: bloc.postedFile != null && bloc.postedFile != "",
                  child: bloc.isVideoFile == false
                      ? Container(
                          padding: const EdgeInsets.all(MARGIN_MEDIUM),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 300,
                                child: Image.network(
                                  bloc.postedFile.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Visibility(
                                  visible: bloc.postedFile != null ||
                                      bloc.postedFile != "",
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
                      : Stack(
                          children: [
                            Container(
                              child: FlickVideoPlayer(
                                flickManager: FlickManager(
                                  videoPlayerController:
                                      VideoPlayerController.network(
                                    "${bloc.postedFile}",
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
                                visible: bloc.postedFile != null &&
                                    bloc.postedFile != "",
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
                      padding: const EdgeInsets.all(MARGIN_MEDIUM),
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
                          child: FlickVideoPlayer(
                            flickManager: bloc.flickManager!,
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
            ),
    );
  }
}

class IconNameRowView extends StatelessWidget {
  final IconData icon;
  final String name;
  final Color color;
  const IconNameRowView(
      {Key? key, required this.icon, required this.name, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      height: null,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: PROFILE_BORDER_COLOR,
        border: Border.all(color: ICON_COLOR, width: 0.3),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: MARGIN_CARD_MEDIUM_2,
          ),
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(
            width: MARGIN_MEDIUM,
          ),
          Text(
            name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: TEXT_REGULAR_2X,
            ),
          ),
        ],
      ),
    );
  }
}

class AddNewPostTextFieldView extends StatelessWidget {
  const AddNewPostTextFieldView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CreatePostBloc>(
      builder: (context, bloc, child) => SizedBox(
        height: ADD_NEW_POST_TEXTFIELD_HEIGHT,
        // height: null,
        child: TextField(
          maxLines: 24,
          controller: TextEditingController(text: bloc.newPostDescription),
          onChanged: (text) {
            bloc.onNewPostTextChanged(text);
          },
          decoration: const InputDecoration(
            hintText: "What's on your mind?",
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
