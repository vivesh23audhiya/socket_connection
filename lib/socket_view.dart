import 'dart:io';
import 'package:flutter/material.dart';
import 'my_controller.dart';
import 'package:get/get.dart';

class SocketView extends StatelessWidget {
  final MyController myController = Get.put(MyController());

  SocketView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Socket.IO'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  myController.connectSocket();
                },
                icon: const Icon(Icons.connected_tv),
              ),
              IconButton(
                onPressed: () {
                  myController.disconnectSocket();
                },
                icon: const Icon(Icons.close),
              ),
              IconButton(
                onPressed: () {
                  myController.checkSocketConnection();
                },
                icon: const Icon(Icons.signal_wifi_statusbar_null_outlined),
              ),
              IconButton(
                onPressed: () {
                  myController.goToNextPage(context);
                },
                icon: const Icon(Icons.next_plan),
              ),
              const Expanded(child: SizedBox.shrink()),
              Obx(() => Text(
                    myController.connectionStatus.value,
                    style: const TextStyle(color: Colors.purple),
                  )),
              const SizedBox(
                width: 24,
              ),
            ],
          ),
          /*Obx(
            () => Center(
              child: myController.imagePath.isEmpty
                  ? Text('No image selected.')
                  : Image.file(
                      myController.imgFile!.value,
                      height: 200.0,
                      width: 200.0,
                    ),
            ),
          ),*/
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Obx(
              () => ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: myController.chatList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          (myController.chatList[index].isSend ?? false)
                              ? const Expanded(
                                  child: SizedBox.shrink(),
                                )
                              : const SizedBox.shrink(),
                          (myController.chatList[index].type ?? '') == "File"
                              ? Obx(
                                  () => Container(
                                    color: Colors.grey.shade200,
                                    padding: const EdgeInsets.all(8),
                                    child: Center(
                                      child: myController.imagePath.isEmpty
                                          ? Text('No image selected.')
                                          : myController.chatList[index]
                                                      .data![0].file ==
                                                  null
                                              ? SizedBox(
                                                  height: 120,
                                                  width: 120,
                                                  child: Center(
                                                    child: SizedBox(
                                                      height: 24,
                                                      width: 24,
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: 4,
                                                        valueColor:
                                                            const AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors.purple),
                                                        backgroundColor:
                                                            Colors.grey.shade200,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Image.file(
                                                  myController.chatList[index]
                                                          .data![0].file ??
                                                      File(''),
                                                  height: 120.0,
                                                  width: 120.0,
                                                ),
                                    ),
                                  ),
                                )
                              : Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      side: BorderSide(
                                          width: 1,
                                          color: (myController
                                                      .chatList[index].isSend ??
                                                  false)
                                              ? Colors.lightGreen
                                              : Colors.blueAccent)),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    /* color:
                                  (myController.chatList[index].isSend ?? false)
                                      ? Colors.lightGreen
                                      : Colors.lightBlueAccent,*/
                                    child: Text(myController
                                            .chatList[index].data![0].message ??
                                        ''),
                                  ),
                                ),
                          (myController.chatList[index].isSend ?? false)
                              ? SizedBox.shrink()
                              : const Expanded(
                                  child: SizedBox.shrink(),
                                )
                        ],
                      ),
                    );
                  }),
            ),
          )),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      //myController.openPickerDialog();
                      myController.sendImageMessage();
                    },
                    icon: const Icon(Icons.image),
                  ),
                  Expanded(
                    child: TextField(
                      controller: myController.messageInputController,
                      style: TextStyle(fontSize: 10),
                      decoration: const InputDecoration(
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (myController.messageInputController.text
                          .trim()
                          .isNotEmpty) {
                        myController.sendMessage();
                      }
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomSheet: Obx(
        () {
          if (myController.isBottomSheetOpen.value) {
            return Container(
              color: Colors.grey.shade200,
              width: double.infinity,
              height: 170,
              child: Column(
                children: [
                  Container(
                    color: Colors.grey.shade200,
                    child: GestureDetector(
                      onTap: () {
                        myController.getImage(true);
                      },
                      child: const ListTile(
                          title: Text(
                        'Camera',
                        style: TextStyle(color: Colors.black),
                      )),
                    ),
                  ),
                  Container(
                    color: Colors.grey.shade200,
                    child: GestureDetector(
                      onTap: () {
                        myController.getImage(false);
                      },
                      child: const ListTile(
                          title: Text(
                        'Gallery',
                        style: TextStyle(color: Colors.black),
                      )),
                    ),
                  ),
                  Container(
                    color: Colors.grey.shade200,
                    child: GestureDetector(
                      onTap: () {
                        myController.closeBottomSheet();
                      },
                      child: const ListTile(
                          title: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black),
                      )),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
