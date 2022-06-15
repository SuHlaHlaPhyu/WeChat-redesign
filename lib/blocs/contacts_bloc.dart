import 'package:flutter/material.dart';
import 'package:wechat_redesign/data/models/data_model.dart';
import 'package:wechat_redesign/data/models/data_model_impl.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';

class ContactsBloc extends ChangeNotifier {
  DataModel dataModel = DataModelImpl();
  List<UserVO>? contactsList;
  bool isDisposed = false;
  bool isLoading = false;

  ContactsBloc() {
    _showLoading();
    dataModel.getContacts().listen((event) {
      contactsList = event;
      _hideLoading();
      _notifySafely();
    });
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
