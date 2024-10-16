class ModelMapel {
  bool? isError;
  String? message;
  List<DataMapel>? data;

  ModelMapel({this.isError, this.message, this.data});

  ModelMapel.fromJson(Map<String, dynamic> json) {
	isError = json['is_error'];
	message = json['message'];
	if (json['data'] != null) {
  	data = <DataMapel>[];
  	json['data'].forEach((v) {
    	data!.add(DataMapel.fromJson(v));
  	});
	}
  }

  Map<String, dynamic> toJson() {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['is_error'] = isError;
	data['message'] = message;
	if (this.data != null) {
  	data['data'] = this.data!.map((v) => v.toJson()).toList();
	}
	return data;
  }
}

class DataMapel {
  int? id;
  String? name;
  String? jenis;
  List<dynamic>? guruId;
  String? keterangan;

  DataMapel({this.id, this.name, this.jenis, this.guruId, this.keterangan});

  DataMapel.fromJson(Map<String, dynamic> json) {
	id = json['id'];
	name = json['name'];
	jenis = json['jenis'];
	// guruId = json['guru_id'];
	guruId = json['guru_id']?.cast<dynamic>();
	keterangan = json['keterangan'] ?? '';
  }

  Map<String, dynamic> toJson() {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = id;
	data['name'] = name;
	data['jenis'] = jenis;
	data['guru_id'] = guruId;
	data['keterangan'] = keterangan;
	return data;
  }
}
