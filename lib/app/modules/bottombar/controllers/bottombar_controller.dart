import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../home/controllers/home_controller.dart';
import '../../mapel/controllers/mapel_controller.dart';

class BottombarController extends GetxController {
  var tabIndex = 0;

  void changeIndex(int index) {
	tabIndex = index;
	switch (index) {
  	case 0:
    	if (!Get.isRegistered<HomeController>()) {
      	Get.put(HomeController());
    	}
    	break;
  	case 1:
    	if (!Get.isRegistered<MapelController>()) {
      	Get.put(MapelController());
    	}
    	break;
	}
	update();
  }


  BotBar({IconData? ikon, String? label}) {
	return BottomNavigationBarItem(
  	icon: Icon(ikon),
  	label: label,
	);
  }

  final count = 0.obs;
  @override
  void onInit() {
	super.onInit();
  }

  @override


  void onReady() {
	super.onReady();
  }

  @override
  void onClose() {
	super.onClose();
  }

  void increment() => count.value++;
}


