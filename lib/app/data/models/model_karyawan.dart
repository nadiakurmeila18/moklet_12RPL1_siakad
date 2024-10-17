class ModelKaryawan {
  bool? isError;
  String? message;
  List<DataKaryawan>? data;

  ModelKaryawan({this.isError, this.message, this.data});

  ModelKaryawan.fromJson(Map<String, dynamic> json) {
	isError = json['is_error'];
	message = json['message'];
	if (json['data'] != null) {
  	data = <DataKaryawan>[];
  	json['data'].forEach((v) {
    	data!.add(DataKaryawan.fromJson(v));
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

class DataKaryawan {
  List<dynamic>? companyId;
  List<dynamic>? resourceId;
 String? employeeType;
  int? id;
  String? name;

  DataKaryawan({this.id, this.name, this.companyId, this.employeeType, this.resourceId});

  DataKaryawan.fromJson(Map<String, dynamic> json) {
	companyId = json['company_id'];
	resourceId = json['resource_id'];
	employeeType = json['employee_type'];
	id = json['id'];
	name = json['name'];
  }

  Map<String, dynamic> toJson() {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['company_id'] = companyId;
	data['resource_id'] = resourceId;
	data['employee_type'] = employeeType;
	data['id'] = id;
	data['name'] = name;
	return data;
  }
}
