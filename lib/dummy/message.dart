import 'dart:io';

import 'user.dart';

class Message {
  final User? sender;
  final String? time;
  final String? text;

  Message({
    this.sender,
    this.time,
    this.text,
  });
}
