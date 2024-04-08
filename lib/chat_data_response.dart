
import 'dart:io';

class ChatDataResponse {
  List<Data>? data;
  bool? isSend;
  String? type;
  ChatDataResponse({this.data,this.isSend,this.type});

  ChatDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  int? count;
  String? message;
  String? messageId;
  String? groupId;
  List<String>? sendTo;
  List<String>? readUserIds;
  String? senderId;
  String? userName;
  File? file;

  Data(
      {this.sId,
      this.count,
      this.message,
      this.messageId,
      this.groupId,
      this.sendTo,
      this.readUserIds,
      this.senderId,
      this.userName,
      this.file});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    count = json['count'];
    message = json['message'];
    messageId = json['messageId'];
    groupId = json['group_id'];
    sendTo = json['sendTo'].cast<String>();
    readUserIds = json['readUserIds'].cast<String>();
    senderId = json['senderId'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['count'] = this.count;
    data['message'] = this.message;
    data['messageId'] = this.messageId;
    data['group_id'] = this.groupId;
    data['sendTo'] = this.sendTo;
    data['readUserIds'] = this.readUserIds;
    data['senderId'] = this.senderId;
    data['userName'] = this.userName;
    return data;
  }
}
