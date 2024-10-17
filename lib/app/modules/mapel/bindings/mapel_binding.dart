import 'package:get/get.dart';

import '../controllers/mapel_tambah_controller.dart';
import '../controllers/mapel_controller.dart';

class MapelBinding extends Bindings {
  @override
  void dependencies() {
	Get.lazyPut<MapelTambahController>(() => MapelTambahController());
	Get.lazyPut<MapelController>(() => MapelController());
  }
}
