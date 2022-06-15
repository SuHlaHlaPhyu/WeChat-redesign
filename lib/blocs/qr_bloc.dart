import 'package:flutter/material.dart';
import 'package:wechat_redesign/data/models/data_model.dart';
import 'package:wechat_redesign/data/models/data_model_impl.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';

class QRBloc extends ChangeNotifier{
  UserVO? currentUser;
  DataModel dataModel = DataModelImpl();

  QRBloc(){
    dataModel.getLoggedInUser().listen((event) {
      currentUser = event;
      notifyListeners();
    });
  }
}