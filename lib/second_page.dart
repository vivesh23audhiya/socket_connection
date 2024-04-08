import 'package:flutter/material.dart';
import 'second_controller.dart';
import 'package:get/get.dart';

class SecondPage extends StatelessWidget {
  final SecondController myController = Get.put(SecondController());

  SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Socket.IO'),
        ),
        body: Container(
          color: Colors.white,
          child: const Center(child: Text("Second Page")),
        )
    );
  }
}
