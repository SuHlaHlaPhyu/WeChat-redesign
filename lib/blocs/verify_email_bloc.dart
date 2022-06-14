import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wechat_redesign/data/models/data_model.dart';
import 'package:wechat_redesign/data/models/data_model_impl.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';

class VerifyEmailBloc extends ChangeNotifier{
  String email = "";
  UserVO? craftUser;
  bool isLoading = false;
  bool isDisposed = false;
  File? chosenFile;

  final DataModel _model = DataModelImpl();

  VerifyEmailBloc(UserVO? user,File? file){
    craftUser = user;
    chosenFile = file;
    _notifySafely();
  }
  void onEmailChanged(String email) {
    craftUser?.email = email;
    _notifySafely();
  }

  Future onTapRegister() {
    _showLoading();
    return _model
        .register(craftUser,chosenFile)
        .whenComplete(() => _hideLoading());
  }
  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}