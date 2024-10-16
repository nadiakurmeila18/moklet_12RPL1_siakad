import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/mapel_controller.dart';

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
    	],
  	),
  	floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
	);
  }
}
