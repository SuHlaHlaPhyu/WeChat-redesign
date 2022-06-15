import 'package:flutter/material.dart';
import 'package:wechat_redesign/data/models/data_model.dart';
import 'package:wechat_redesign/data/models/data_model_impl.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';

class MeBloc extends ChangeNotifier {
  UserVO? loggedInUser;
  final DataModel _model = DataModelImpl();

  MeBloc() {
    _model.getLoggedInUser().listen((event) {
      loggedInUser = event;
      notifyListeners();
    });
  }

  Future onTapLogout() {
    return _model.logOut();
  }
}
