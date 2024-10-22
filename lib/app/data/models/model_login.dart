class modelLogin {
  bool? isError;
  String? message;
  DataLogin? data;

  modelLogin({this.isError, this.message, this.data});

  modelLogin.fromJson(Map<String, dynamic> json) {
	isError = json['is_error'];
	message = json['message'];
	data = json['data'] != null ? new DataLogin.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['is_error'] = this.isError;
	data['message'] = this.message;
	if (this.data != null) {
  	data['data'] = this.data!.toJson();
	}
	return data;
  }
}

class DataLogin {
  String? user;
  String? apiKey;

  DataLogin({this.user, this.apiKey});

  DataLogin.fromJson(Map<String, dynamic> json) {
	user = json['User'];
  apiKey = json['api-key'];
  }

  Map<String, dynamic> toJson() {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['User'] = this.user;
	data['api-key'] = this.apiKey;
	return data;
  }
}
