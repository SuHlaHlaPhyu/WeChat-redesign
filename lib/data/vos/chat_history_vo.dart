
import 'package:wechat_redesign/data/vos/user_vo.dart';

class ChatHistoryVO {
 UserVO? chatContact;
 String? lastMessage;

 ChatHistoryVO({this.chatContact, this.lastMessage});

 @override
  String toString() {
    return 'ChatHistoryVO{chatContact: $chatContact, lastMessage: $lastMessage}';
  }
}
