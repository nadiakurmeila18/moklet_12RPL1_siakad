import 'dart:convert';
import 'package:belajar_flutter/app/data/models/model_karyawan.dart';
import "package:http/http.dart" as http;
import '../services/constant.dart';

class RepositoryKaryawan {
  RepositoryKaryawan();

  Future<ModelKaryawan> loadKaryawan() async {
  addCookies();
  String url = CORS_ANYWHERE + DOMAIN;
  var res = http.Request(
	'GET',
	Uri.parse('$url/send_request?model=hr.employee'),
  );
  res.headers.addAll(defaultHeader);
  http.StreamedResponse response = await res.send();
  try {
	if (response.statusCode == 200) {
  	var jsonString = await response.stream.bytesToString();
  	return ModelKaryawan.fromJson(jsonDecode(jsonString));
	} else {
  	return ModelKaryawan(isError: true, data: [], message: 'Gagal Bad Request');
	}
  } catch (e) {
	return ModelKaryawan(isError: true, data: [], message: 'Gagal Catch');
  }
}

}
