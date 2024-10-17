import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/repository_karyawan.dart';
import '../../../data/repositories/repository_mapel.dart';
import '../../../data/models/model_karyawan.dart';
import '../../../routes/app_pages.dart';

class MapelTambahController extends GetxController {
  var textController1 = TextEditingController().obs; // Nama
  var textController2 = TextEditingController().obs; // Jenis
  var textController3 = TextEditingController().obs; // Guru Pengajar
  var textController4 = TextEditingController().obs; // Keterangan

  Rx<bool> isLoaded = false.obs;
  Rx<ModelKaryawan> karyawan = ModelKaryawan().obs;
  final count = 0.obs;

  Widget FormTextField({
  String? labelText,
  TextEditingController? controller,
  IconData? ikon,
  Widget? ikonend,
  TextInputType? tipeinput,
  VoidCallback? onTap,
  }) {
	return GestureDetector(
  	onTap: onTap,
  	child: AbsorbPointer(
    	absorbing: onTap != null,
    	child: TextFormField(
      	controller: controller,
      	decoration: InputDecoration(
        	labelText: labelText,
        	prefixIcon: ikon != null ? Icon(ikon) : null,
        	border: OutlineInputBorder(
          	borderRadius: BorderRadius.circular(10),
        	),
        	focusedBorder: OutlineInputBorder(
          	borderRadius: BorderRadius.circular(10),
			borderSide: BorderSide(color: Colors.blue, width: 2),
        	),
        	enabledBorder: OutlineInputBorder(
          	borderRadius: BorderRadius.circular(10),
          	borderSide: BorderSide(color: Colors.grey),
        	),
        	suffixIcon: ikonend,
      	),
      	keyboardType: tipeinput,
    	),
  	),
	);
  }

  var selectedKaryawanId = Rxn<int>();
  RxList<DataKaryawan> guruPengajar = <DataKaryawan>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  void postMapel() async {
	String nama = textController1.value.text;
	String jenis = textController2.value.text;
	int guru = selectedKaryawanId.value!;
	String keterangan = textController4.value.text;

	var params = {
  	"fields": ["name", "jenis", "guru_id", "keterangan"],
  	"values": {
    	"name": nama,
    	"jenis": jenis,
    	"guru_id": guru,
    	"keterangan": keterangan,
  	}
	};

	isLoading.value = true;
	errorMessage.value = '';

	var loginResponse = await RepositoryMapel().postMapel(body: params);

	if (loginResponse != null) {
  	final responseString = await loginResponse.stream.bytesToString();
	final Map<String, dynamic> jsonResponse = json.decode(responseString);

  	if (!jsonResponse['is_error'] || jsonResponse['message'] == "Success") {
  	Get.offAllNamed(Routes.BOTTOMBAR, arguments: {'index': 1});
  	Get.snackbar(
    	"Berhasil",
    	"Data ditambahkan",
    	snackPosition: SnackPosition.TOP,
    	backgroundColor: Colors.white,
  	);
  	} else {
    	errorMessage.value = jsonResponse['message'];
    	Get.snackbar(
      	"Error",
      	"Penambahan data gagal: ${jsonResponse['message']}",
      	snackPosition: SnackPosition.TOP,
      	backgroundColor: Colors.white,
    	);
  	}
	} else {
  	errorMessage.value = 'Gagal terhubung ke server.';
  	Get.snackbar(
    	"Error",
    	"Gagal terhubung ke server.",
    	snackPosition: SnackPosition.TOP,
    	backgroundColor: Colors.white,
  	);
	}
	isLoading.value = false;
  }

  void getKaryawan() {
	isLoaded(false);
	RepositoryKaryawan().loadKaryawan().then((ModelKaryawan response) {
    	guruPengajar.assignAll(response.data ?? []);
    	if (guruPengajar.isNotEmpty) {
      	selectedKaryawanId.value = guruPengajar.first.id;
    	}
  	isLoaded(true);
	});
  }
}