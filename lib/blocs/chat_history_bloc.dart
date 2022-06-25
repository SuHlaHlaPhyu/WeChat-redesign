import 'package:flutter/material.dart';
import 'package:wechat_redesign/data/models/data_model.dart';
import 'package:wechat_redesign/data/models/data_model_impl.dart';
import 'package:wechat_redesign/data/vos/chat_history_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';

class ChatHistoryBloc extends ChangeNotifier {
  DataModel dataModel = DataModelImpl();
  List<String>? strList;

  List<UserVO> chatUser = [];
  List<String> msgList = [];

  List<ChatHistoryVO> result = [];

  bool isLoading = false;
  bool isDisposed = false;

  ChatHistoryBloc() {
    dataModel.chatHistory().listen((event) {
      if(event[0] == "No Data"){
        strList?.clear();
        _notifySafely();
      }else{
        strList = event;
        _notifySafely();
      }
      print("====>contact list  $strList");
      getChatHistory(strList);
      notifyListeners();
    });
  }

  Future<void> getChatHistory(List<String>? strList) async {
    result.clear();
    strList?.forEach((contact) async {
      result.add(ChatHistoryVO(
          chatContact: await dataModel.getUserByID(contact),
          lastMessage:
              await dataModel.getConversationsLastMessage(contact).first));
      notifyListeners();
    });
  }

  void onTapDeleteConversation(String contactUserID) {
    _showLoading();
    dataModel.deleteConversation(contactUserID).whenComplete(() {
      _hideLoading();
      dataModel.chatHistory();
      notifyListeners();
    });
    notifyListeners();
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
}
