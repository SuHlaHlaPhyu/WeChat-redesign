import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';

class MomentDetailsPage extends StatelessWidget {
  final MomentVO? moment;
  const MomentDetailsPage({Key? key, required this.moment}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${moment?.userName}",
            style: const TextStyle(
              color: MOMENT_SUBTEXT_COLOR,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            "${moment?.description}",
            style: const TextStyle(
              color: MOMENT_SUBTEXT_COLOR,
              fontSize: TEXT_SMALL,
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
              : Container(
                  margin: const EdgeInsets.only(
                      left: 8.0, right: 8.0, bottom: 15.0),
                  child: FlickVideoPlayer(
                    flickManager: FlickManager(
                      videoPlayerController: VideoPlayerController.network(
                        "${moment?.postFile}",
                      ),
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
                ),
        ],
      ),
    );
  }
}
