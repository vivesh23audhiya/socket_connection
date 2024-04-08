
class SendDataDataResponse {
  String? message;
  String? groupId;
  String? groupName;
  String? senderId;
  bool? isFile;
  List<String>? readUserIds;
  Metadata? metadata;
  String? type;
  bool? emailNotified;
  bool? isBroadcast;
  bool? isEmailMessage;
  String? fileUrl;
  List<String>? sendTo;
  bool? isDeleted;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SendDataDataResponse(
      {this.message, this.groupId, this.groupName, this.senderId, this.isFile, this.readUserIds, this.metadata, this.type, this.emailNotified, this.isBroadcast, this.isEmailMessage, this.fileUrl, this.sendTo, this.isDeleted, this.sId, this.createdAt, this.updatedAt, this.iV});

  SendDataDataResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    groupId = json['groupId'];
    groupName = json['groupName'];
    senderId = json['senderId'];
    isFile = json['isFile'];
    readUserIds = json['readUserIds'].cast<String>();
    metadata =
    json['metadata'] != null ? new Metadata.fromJson(json['metadata']) : null;
    type = json['type'];
    emailNotified = json['emailNotified'];
    isBroadcast = json['isBroadcast'];
    isEmailMessage = json['isEmailMessage'];
    fileUrl = json['fileUrl'];
    sendTo = json['sendTo'].cast<String>();
    isDeleted = json['isDeleted'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['groupId'] = this.groupId;
    data['groupName'] = this.groupName;
    data['senderId'] = this.senderId;
    data['isFile'] = this.isFile;
    data['readUserIds'] = this.readUserIds;
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
    data['type'] = this.type;
    data['emailNotified'] = this.emailNotified;
    data['isBroadcast'] = this.isBroadcast;
    data['isEmailMessage'] = this.isEmailMessage;
    data['fileUrl'] = this.fileUrl;
    data['sendTo'] = this.sendTo;
    data['isDeleted'] = this.isDeleted;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Metadata {




Metadata.fromJson
(
Map<String, dynamic> json) {
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
return data;
}
}