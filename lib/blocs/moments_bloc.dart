import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_redesign/data/models/data_model.dart';
import 'package:wechat_redesign/data/models/data_model_impl.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';

class MomentsBloc extends ChangeNotifier {
  List<MomentVO>? moments;
  bool isLoading = true;
  bool isDisposed = false;
  FlickManager? flickManager;
  UserVO? userVO;

  final DataModel model = DataModelImpl();

  MomentsBloc() {
    model.getMoments().listen((list) {
      moments = list.reversed.toList();
      model.getLoggedInUser().listen((event) {
        userVO = event;
        _notifySafely();
      });
      isLoading = false;
      _notifySafely();
    });
  }

  void onTapDeletePost(int momentId) async {
    await model.deleteMoment(momentId);
    _notifySafely();
  }

  FlickManager? playVideo(String url) {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        url,
      ),
      autoPlay: false,
    );
    return flickManager;
  }

  @override
  void dispose() {
    flickManager?.dispose();
    super.dispose();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }
}
