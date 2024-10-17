import 'package:belajar_flutter/app/data/models/model_mapel.dart';
import 'package:belajar_flutter/app/data/repositories/repository_mapel.dart';
import 'package:get/get.dart';

class MapelController extends GetxController {
  //TODO: Implement MapelController

  final count = 0.obs;
  Rx<bool> isLoaded = false.obs;
  Rx<ModelMapel> mapel = ModelMapel().obs;

  @override
  void onInit() {
	super.onInit();
	getMapel();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  Future<void> getMapel() async {
    isLoaded(false);
    RepositoryMapel().loadMapel().then((ModelMapel response) {
      mapel(response);
      isLoaded(true);
    });
  }

  void updateMapel(int id, Map<String, dynamic> data) {
  RepositoryMapel().updateMapel(id: id, body: data).then((response) {
    if (response != null) {
      getMapel();
    }
  });
}


  void increment() => count.value++;
}
