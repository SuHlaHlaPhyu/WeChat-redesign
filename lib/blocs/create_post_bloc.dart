import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_redesign/data/models/data_model.dart';
import 'package:wechat_redesign/data/models/data_model_impl.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';

class CreatePostBloc extends ChangeNotifier {
  PlatformFile? chosenFile;
  bool isDisposed = false;
  FlickManager? flickManager;
  File? file;

  String? newPostDescription;
  String? userName;
  String? profilePicture;
  bool isVideoFile = false;
  String? postedFile;
  MomentVO? moment;

  bool isLoading = false;
  bool isEditMode = false;
  bool isRemove = false;
  bool down = true;

  final DataModel _model = DataModelImpl();
  CreatePostBloc({int? id}) {
    if (id != null) {
      isEditMode = true;
      isRemove = true;
      prepareDataForEditMode(id);
    } else {
      prepareDataForNewPostMode();
    }
  }

  void prepareDataForEditMode(int newsFeedId) {
    _model.getMomentById(newsFeedId).listen((newsFeedItem) {
      userName = newsFeedItem.userName ?? "";
      profilePicture = newsFeedItem.profilePicture ?? "";
      newPostDescription = newsFeedItem.description ?? "";
      postedFile = newsFeedItem.postFile ?? "";
      isVideoFile = newsFeedItem.isVideo ?? false;
      moment = newsFeedItem;
      print(
          "postedFile $postedFile \n isEditMode $isEditMode \n isVideo $isVideoFile \n chosenFile $chosenFile ");
      _notifySafely();
    });
  }

  void onFileChosen(PlatformFile? imageFile) {
    if (imageFile?.extension != "mp4") {
      chosenFile = imageFile;
    } else {
      isVideoFile = true;
      chosenFile = imageFile;
      flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(
          "${imageFile?.path.toString()}",
        ),
      );
    }
    _notifySafely();
  }

  void prepareDataForNewPostMode() {
    userName = "Su Hla Phyu";
    profilePicture =
        "https://bestprofilepictures.com/wp-content/uploads/2021/08/Anime-Girl-Profile-Picture.jpg";
    _notifySafely();
  }

  void onTapDeleteImage() {
    chosenFile = null;
    postedFile = null;
    isRemove = false;
    _notifySafely();
  }

  void setFlag(){
    down = !down;
    _notifySafely();
  }

  void onNewPostTextChanged(String newPostDescription) {
    this.newPostDescription = newPostDescription;
  }

  Future<void> createNewMoment() {
    if (chosenFile == null) {
      file = null;
      return _model.addNewMoment(newPostDescription ?? "", file, isVideoFile);
    } else {
      return _model.addNewMoment(newPostDescription ?? "",
          File("${chosenFile?.path.toString()}"), isVideoFile);
    }
  }

  Future<dynamic> editMomentPost() {
    moment?.description = newPostDescription;
    moment?.postFile = postedFile;
    if (chosenFile != null) {
      return _model.editMoment(moment, File("${chosenFile?.path.toString()}"));
    } else if (chosenFile == null) {
      file = null;
      return _model.editMoment(moment, file);
    } else {
      return Future.error("Error");
    }
  }

  Future onTapAddNewMoment() {
    isLoading = true;
    _notifySafely();
    if (isEditMode) {
      return editMomentPost().then((value) {
        isLoading = false;
        _notifySafely();
      });
    } else {
      return createNewMoment().then((value) {
        isLoading = false;
        _notifySafely();
      });
    }
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }
}
