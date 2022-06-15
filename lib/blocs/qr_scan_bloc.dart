import 'package:flutter/material.dart';
import 'package:wechat_redesign/data/models/data_model.dart';
import 'package:wechat_redesign/data/models/data_model_impl.dart';

class QRScanBloc extends ChangeNotifier {
  String qrcode = "";
  DataModel model = DataModelImpl();
  bool isLoading = false;
  bool isDisposed = false;

  Future<void> addToContact(String qrCode) {
    _showLoading();
   return model.addToContact(qrCode).whenComplete(() => _hideLoading());
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
