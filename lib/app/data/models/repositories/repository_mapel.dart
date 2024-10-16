import 'dart:convert';
import 'package:belajar_flutter/app/data/models/model_mapel.dart';
import 'package:belajar_flutter/app/data/models/services/constant.dart';
import "package:http/http.dart" as http;


class RepositoryMapel {
  RepositoryMapel();

  Future<ModelMapel> loadMapel() async {
	addCookies();
	String url = CORS_ANYWHERE + DOMAIN;
	var res = http.Request(
  	'GET',
  	Uri.parse('$url/send_request?model=moklet.mapel'),
	);
	res.headers.addAll(defaultHeader);
	http.StreamedResponse response = await res.send();
	try {
  	if (response.statusCode == 200) {
    	var jsonString = await response.stream.bytesToString();
    	return ModelMapel.fromJson(jsonDecode(jsonString));
  	} else {
    	return ModelMapel(
        	isError: true, data: [], message: 'Gagal Bad Request');
  	}
	} catch (e) {
  	print(e);
  	return ModelMapel(isError: true, data: [], message: 'Gagal Catch');
	}
  }
}
