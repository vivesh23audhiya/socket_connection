import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SecondController extends GetxController {
  var count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void increment() {
    count++;
    update(); // Manually trigger a UI update
  }
}
