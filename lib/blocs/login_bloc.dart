import 'package:flutter/material.dart';
import 'package:wechat_redesign/data/models/data_model.dart';
import 'package:wechat_redesign/data/models/data_model_impl.dart';

class LoginBloc extends ChangeNotifier{
  String email = "";
  String password = "";
  bool isLoading = false;
  bool isDisposed =false;

  void onEmailChanged(String email) {
    this.email = email;
  }

  void onPasswordChanged(String password) {
    this.password = password;
  }

  /// Model
  final DataModel _model = DataModelImpl();

  Future onTapLogin() {
    _showLoading();
    return _model.login(email, password).whenComplete(() => _hideLoading());
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
