import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_connection/chat_data_response.dart';
import 'package:socket_connection/contant.dart';
import 'package:socket_connection/send_data_response.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'second_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_connection/picker_ui.dart';

class MyController extends GetxController {
  // Define your variables and methods here
  var count = 0.obs;
  var isBottomSheetOpen = false.obs;
  late IO.Socket _socket;
  final TextEditingController messageInputController = TextEditingController();
  final userId = "894";
  final groupName = '240-894'; //
  var connectionStatus = "-".obs;
  RxList<ChatDataResponse> chatList = <ChatDataResponse>[].obs;

  final ImagePicker _picker = ImagePicker();
  var imagePath = ''.obs;

  late Rx<File>? imgFile;

  void getImage(bool isCamera) async {
    closeBottomSheet();
    final XFile? image = await _picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (image != null) {
      imgFile = File(image.path).obs;
      imagePath.value = imgFile?.value.path ?? '';
    }

    sendImageData("File");
  }

//https://vmechatapi.demo.brainvire.dev/groupName=&senderId=377
  @override
  void onInit() {
    super.onInit();

    //_socket = IO.io('https://vmechatapi.demo.brainvire.dev/',
    _socket = IO.io(
      'https://stagingapi.vmeonline.com/',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setQuery({'groupName': groupName})
          .setQuery({"senderId": userId})
          .disableAutoConnect()
          .build(),
    );
    _socket.connect();
    _connectSocket();
  }

  void sendMessage() {
    _socket.emit(Contant.CHAT_MESSAGE, {
      messageInputController.text.toString(),
      userId,
      "onetoone",
      groupName,
      'vivesh' + " " + 'audhiya',
      "",
      '',
    });

    messageInputController.text = '';
  }

  /// this for display on bottom sheet menu for filter
  void showCustomBottomSheetDialog({
    Color? backgroundColor,
    Color? titleColor,
    bool? isScrollControlled,
    bool? enableDrag,
    double? elevation,
    bool? isDismissible,
    void Function(String strProductName)? onTap,
    void Function()? onCloseTab,
    Widget? widget,
  }) {
    Get.bottomSheet(
      isScrollControlled: isScrollControlled!,
      enableDrag: enableDrag!,
      elevation: elevation!,
      isDismissible: isDismissible!,
      backgroundColor: backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0)),
      ),
      widget!,
    );
  }

  void sendImageMessage() {
    Map<String, dynamic> mainObject = {
      'size': 0,
      'name': 'Img_7994958104834677636_1702989006838_V.png',
      'senderId': userId,
      'type': 'onetoone',
      'message': '',
      'groupName': groupName,
      'userName': 'liam byers',
      'plateform': 'mobile',
    };

    var jsonObj = {
      "message":"File Attached","groupId":"653b559bdf1bbc1fcf93f8b6","groupName":"240-894","senderId":"240","fileName":"Img_7994958104834677636_1702989006838_V.png","isFile":true,"fileType":".png","filePath":"temp\/","readUserIds":["240","240"],"metadata":{},"type":"onetoone","emailNotified":false,"isBroadcast":false,"isEmailMessage":false,"sendTo":["894","240"],"isDeleted":false,"_id":"65818c80f6ea8b006f033563","createdAt":"2023-12-19T12:28:48.795Z","updatedAt":"2023-12-19T12:28:48.795Z","__v":0,"userName":"liam byers"
    };

//{"size":0,"name":"Img_7994958104834677636_1702989006838_V.png","senderId":"240",
// "type":"onetoone","message":"","groupName":"240-894","userName":"liam byers","plateform":"mobile"}

    //{"size":0,"name":"Img_2783129384741172113_1702987336531_V.png","senderId":"240","type":"onetoone","message":"","groupName":"240-894","userName":"liam byers","plateform":"mobile"}

    // Convert the Dart Map to a JSON string
    String jsonString = jsonEncode(mainObject);
    print("<<<<<FileData:$jsonString>>>>>");

    _socket.emit('file', jsonString);
  }

  void disconnectSocket() {
    _socket.disconnect();
    if (_socket.disconnected) {
      print('_socket disconnected');
    } else {
      _socket.disconnect();
    }
  }

  void connectSocket() {
    if (_socket.disconnected) {
      _socket.connect();
    } else {
      print('_socket connected');
    }
  }

  void checkSocketConnection() {
    if (_socket.disconnected) {
      print('_socket disconnected');
      connectionStatus.value = 'socket disconnected';
    } else {
      print('_socket connected');
      connectionStatus.value = 'socket connected';
    }
  }

  void goToNextPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SecondPage()));
  }

  void incriment() {
    count.value = count.value + 1;
  }

  _connectSocket() {
    _socket.onConnect((data) {
      print('Connection established');
      connectionStatus.value = 'Connection established';
    });
    _socket.onConnectError((data) {
      print('Connect Error: $data');
      connectionStatus.value = 'Connect Error';
    });
    _socket.onDisconnect((data) {
      print('Socket.IO server disconnected');
      connectionStatus.value = 'Server disconnected';
    });

    _socket.on(Contant.CHAT_MESSAGE, (data) {
      print("CHAT_MESSAGE data:${jsonEncode(data)}");
    });
    _socket.on(Contant.RECEIVED, (data) {
      print("RECEIVED data:${jsonEncode(data)}");
      sendData(data);
    });
    _socket.on(Contant.NOTIFY_UNREAD_GLOBAL_COUNT, (data) {
      print("NOTIFY_UNREAD_GLOBAL_COUNT data:${jsonEncode(data)}");
      addList(data);
    });
    _socket.on(Contant.NEW_CHAT_CONNECT, (data) {
      print("NEW_CHAT_CONNECT data:${jsonEncode(data)}");
    });
    _socket.on(Contant.DELETE_GROUP, (data) {
      print("DELETE_GROUP data:${jsonEncode(data)}");
    });
    _socket.on(Contant.ADDED_USER, (data) {
      print("ADDED_USER data:${jsonEncode(data)}");
    });
    _socket.on(Contant.REMOVED_USER, (data) {
      print("REMOVED_USER data:${jsonEncode(data)}");
    });
    _socket.on(Contant.DELETE_IMAGE, (data) {
      print("DELETE_IMAGE data:${jsonEncode(data)}");
    });
    _socket.on(Contant.UNBLOCK_USER, (data) {
      print("UNBLOCK_USER data:${jsonEncode(data)}");
    });
    _socket.on(Contant.BLOCK_USER, (data) {
      print("BLOCK_USER data:${jsonEncode(data)}");
    });
  }

  void addList(dynamic data) {
    final Map<String, dynamic> responseData = json.decode(jsonEncode(data));
    var receivedData = ChatDataResponse.fromJson(responseData);
    receivedData.isSend = false;
    chatList.insert(0, receivedData);
    chatList.refresh();
  }

  void sendData(dynamic data) {
    final Map<String, dynamic> responseData = json.decode(jsonEncode(data));
    var sendData = SendDataDataResponse.fromJson(responseData);
    var d = Data(
      message: sendData.message,
    );
    chatList.insert(0, ChatDataResponse(data: [d], isSend: true, type: ''));
    chatList.refresh();
  }

  void sendImageData(String type) {
    var d = Data(message: "ImageFile", file: null);
    chatList.insert(0, ChatDataResponse(data: [d], isSend: true, type: type));
    chatList.refresh();

    Future.delayed(const Duration(seconds: 3), () async {
      chatList[0] = ChatDataResponse(
          data: [Data(message: "ImageFile", file: imgFile?.value)],
          isSend: true,
          type: type);
      chatList.refresh();
    });
  }

  void increment() {
    count++;
    update(); // Manually trigger a UI update
  }

  void closeBottomSheet() {
    isBottomSheetOpen.value = false;
  }

  void openPickerDialog() {
    isBottomSheetOpen.value = true;
  }
}
