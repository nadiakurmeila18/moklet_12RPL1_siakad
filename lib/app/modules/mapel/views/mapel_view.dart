import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/model_mapel.dart';

import '../../../data/repositories/repository_mapel.dart';
import '../controllers/mapel_controller.dart';
import '../../../routes/app_pages.dart';

class MapelView extends GetView<MapelController> {
  const MapelView({super.key});
  @override
  Widget build(BuildContext context) {
	return Scaffold(
  	appBar: AppBar(
    	title: const Text('MATA PELAJARAN'),
    	centerTitle: true,
  	),
  	body: Padding(
    	padding: const EdgeInsets.all(8.0),
    	child: Obx(
      	() {
          if (!Get.isRegistered<MapelController>()) {
        	return Center(child: CircularProgressIndicator());
      	}
     	 
      	final controller = Get.find<MapelController>();

          
        	if (!controller.isLoaded.value) {
          	return Center(child: CircularProgressIndicator());
        	}

        	if (controller.mapel.value.data == null || controller.mapel.value.data!.isEmpty) {
          	return Center(child: Text('Data kosong.'));
        	}

        	return ListView.builder(
          	itemCount: controller.mapel.value.data?.length ?? 0,
          	itemBuilder: (context, index) {
            	final element = controller.mapel.value.data![index];
            	return Card(
              	margin: const EdgeInsets.symmetric(vertical: 8.0),
              	elevation: 5,
              	child: Padding(
                	padding: const EdgeInsets.all(16.0),
                	child: Column(
                  	crossAxisAlignment: CrossAxisAlignment.start,
                  	children: [
                    	Text(
                      	'${element.name ?? 'N/A'}',
                      	style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    	),
                    	                  	SizedBox(height: 8),
                    	Text(
                      	'Jenis: ${element.jenis ?? 'N/A'}',
                      	style: TextStyle(fontSize: 14),
                    	),
                    	SizedBox(height: 8),
                    	Text(
                      	'Guru Pengajar: ${element.guruId != null && element.guruId!.isNotEmpty ? element.guruId![1] : 'N/A'}',
                      	style: TextStyle(fontSize: 14),
                    	),
                      SizedBox(height: 8),
                    	Text(
                      	'Keterangan: ${element.keterangan ?? 'N/A'}',
                      	style: TextStyle(fontSize: 14),
                    	),
                      SizedBox(height: 8,),
                      ElevatedButton(
                         onPressed: () {
                            _showUpdateModal(context, element);
                          },
                          child: Text('Update'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            print('Menghapus mapel dengan ID: ${element.id}');
                            await controller.deleteMapel(element.id!);
                          },
                          child: Text('Hapus'),
                        ),

                  	],
                	),
              	),
            	);
          	},
        	);
      	},
    	),
  	),
  	floatingActionButton: Column(
    	mainAxisAlignment: MainAxisAlignment.end,
    	crossAxisAlignment: CrossAxisAlignment.end,
    	children: [
      	FloatingActionButton(
        	onPressed: () {
          	controller.getMapel();
        	},
        	child: Icon(Icons.refresh),
        	backgroundColor: Colors.red,
      	),
      	SizedBox(height: 10),
      	FloatingActionButton(
        	onPressed: () {
          	Get.toNamed(Routes.MAPELTAMBAH);
        	},
        	child: Icon(Icons.add),
        	backgroundColor: Colors.red,
      	),
      	SizedBox(height: 10),
    	],
  	),
  	floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
	);
  }
}
void _showUpdateModal(BuildContext context, DataMapel element) {
  final _nameController = TextEditingController(text: element.name);
  final _jenisController = TextEditingController(text: element.jenis);
  final _keteranganController = TextEditingController(text: element.keterangan);
  final _guruIdController = TextEditingController(text: element.guruId != null && element.guruId!.isNotEmpty ? element.guruId![0].toString() : '');
  final repository = RepositoryMapel();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update Mata Pelajaran'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama Mapel'),
              ),
              TextField(
                controller: _jenisController,
                decoration: InputDecoration(labelText: 'Jenis Mapel'),
              ),
              TextField(
                controller: _keteranganController,
                decoration: InputDecoration(labelText: 'Keterangan'),
              ),
              TextField(
                controller: _guruIdController,
                decoration: InputDecoration(labelText: 'ID Guru Pengajar'),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              final updatedData = {
                "fields": ["name", "jenis", "guru_id", "keterangan"],
                  "values": {
                    "name": _nameController.text,
                    "jenis": _jenisController.text,
                    "guru_id": int.parse(_guruIdController.text),
                    "keterangan": _keteranganController.text,
                  }
              };
            bool isSuccess = await repository.updateMapel(element.id!, updatedData);
              if (isSuccess) {
                Navigator.of(context).pop();
                Get.find<MapelController>().getMapel();
                Get.snackbar('Update', 'Mata Pelajaran berhasil diupdate');
              } else {
                Get.snackbar('Update', 'Gagal mengupdate Mata Pelajaran');
              }
            },
            child: Text('Update'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}




             
                
