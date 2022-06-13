import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ChattingBloc extends ChangeNotifier{
  PlatformFile? chosenFile;
  bool isDisposed = false;
  File? chosenImage;
  bool? isFromCamera = false;

  void onFileChosen(PlatformFile? imageFile) {
    if (imageFile?.extension != "mp4") {
      chosenFile = imageFile;
    } else {
      chosenFile = imageFile;
    }
    _notifySafely();
  }

  void onImageChosen(File imageFile, Uint8List bytes){
    chosenImage = imageFile;
    isFromCamera = true;
    notifyListeners();
  }

  void onTapDeleteImage() {
    chosenFile = null;
    chosenImage = null;
    isFromCamera = false;
    _notifySafely();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }
}