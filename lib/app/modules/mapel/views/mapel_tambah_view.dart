import 'package:flutter/material.dart';
import '../../mapel/controllers/mapel_tambah_controller.dart';
import 'package:get/get.dart';

class MapelTambahView extends GetView<MapelTambahController> {
  const MapelTambahView({super.key});

  @override
  Widget build(BuildContext context) {
	return Scaffold(
  	appBar: AppBar(
    	title: const Text('Tambah Mapel'),
    	centerTitle: true,
  	),
  	body: Obx(() {
    	if (!controller.isLoaded.value) {
      	return Center(child: CircularProgressIndicator());
    	}
    	return Padding(
      	padding: const EdgeInsets.all(20.0),
      	child: ListView(
        	children: [
          	Obx(() => controller.FormTextField(
            	labelText: 'Nama',
            	controller: controller.textController1.value,
            	ikon: Icons.person,
            	tipeinput: TextInputType.text,
          	)),
          	const SizedBox(height: 20),
          	Obx(() => DropdownButtonFormField<String>(
            	value: controller.textController2.value.text.isNotEmpty
                	? controller.textController2.value.text
                	: null,
            	items: ['umum', 'kejuruan']
                	.map((label) => DropdownMenuItem(
                      	child: Text(label),
                      	value: label,
                    	))
                	.toList(),
            	onChanged: (value) {
              	controller.textController2.value.text = value!;
            	},
              decoration: InputDecoration(
              	labelText: 'Jenis',
              	prefixIcon: const Icon(Icons.work),
              	border: OutlineInputBorder(
                	borderRadius: BorderRadius.circular(10),
              	),
              	focusedBorder: OutlineInputBorder(
                	borderRadius: BorderRadius.circular(10),
                	borderSide: const BorderSide(color: Colors.blue, width: 2),
              	),
              	enabledBorder: OutlineInputBorder(
                	borderRadius: BorderRadius.circular(10),
                	borderSide: const BorderSide(color: Colors.grey),
              	),
            	),
          	)),
          	const SizedBox(height: 20),
          	Obx(() => DropdownButtonFormField<int>(
            	value: controller.selectedKaryawanId.value,
            	items: controller.guruPengajar.map((guru) {
              	return DropdownMenuItem<int>(
                	value: guru.id,
                	child: Text(guru.name ?? ''),
              	);
            	}).toList(),
            	onChanged: (value) {
              	controller.selectedKaryawanId.value = value;
            	},
            	decoration: InputDecoration(
              	labelText: 'Guru Pengajar',
              	prefixIcon: const Icon(Icons.grade),
              	border: OutlineInputBorder(
                	borderRadius: BorderRadius.circular(10),
              	),
              	focusedBorder: OutlineInputBorder(
                	borderRadius: BorderRadius.circular(10),
                	borderSide: const BorderSide(color: Colors.blue, width: 2),
              	),
              	enabledBorder: OutlineInputBorder(
                	borderRadius: BorderRadius.circular(10),
                	borderSide: const BorderSide(color: Colors.grey),
              	),
                	),
          	)),
          	const SizedBox(height: 20),
          	Obx(() => controller.FormTextField(
            	labelText: 'Keterangan',
            	controller: controller.textController4.value,
            	ikon: Icons.edit,
            	tipeinput: TextInputType.phone,
          	)),
          	const SizedBox(height: 20),
          	ElevatedButton(
            	onPressed: () {
              	controller.postMapel();
            	},
            	child: const Text('Simpan'),
          	),
        	],
      	),
    	);
  	}),
	);
  }
}
