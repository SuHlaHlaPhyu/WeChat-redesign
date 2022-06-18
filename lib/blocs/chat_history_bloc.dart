import 'package:flutter/material.dart';
import 'package:wechat_redesign/data/models/data_model.dart';
import 'package:wechat_redesign/data/models/data_model_impl.dart';
import 'package:wechat_redesign/data/vos/message_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/network/data_agent.dart';
import 'package:wechat_redesign/network/data_agent_impl.dart';

class ChatHistoryBloc extends ChangeNotifier {
  DataModel dataModel = DataModelImpl();
  DataAgent dataAgent = DataAgentImpl();
  List<String>? strList;

  List<UserVO> chatUser = [];
  List<List<MessageVO>> msgList = [];

  ChatHistoryBloc() {
    dataAgent.chatHistory().listen((event) {
      strList = event;
      getChatHistory(strList);
      notifyListeners();
    });
  }
  Future<void> getChatHistory(List<String>? strList) async {
    strList?.forEach((contact) async {
      chatUser.add(await dataAgent.getUserByID(contact));
      notifyListeners();
      msgList.add(await dataAgent.getConversationsList(contact).first);
      notifyListeners();
    });
  }
}
