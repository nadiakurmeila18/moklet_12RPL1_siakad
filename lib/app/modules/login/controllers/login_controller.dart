import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/constant.dart';
import '../../../routes/app_pages.dart';
import '../../../data/repositories/repository_login.dart';

class LoginController extends GetxController {
  var txtUsername = TextEditingController().obs;
  var txtPassword = TextEditingController().obs;
  var isPasswordHidden = true.obs;
  var rememberUser = false.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  void togglePasswordVisibility() {
	isPasswordHidden.value = !isPasswordHidden.value;
  }

  void authLogin() async {
	String username = txtUsername.value.text;
	String password = txtPassword.value.text;
	var params = {
  	'db': DB_NAME,
  	'username': username,
  	'password': password,
	};

	isLoading.value = true;
	errorMessage.value = '';

	var loginResponse = await RepositoryLogin().login(body: params);

	if (loginResponse != null && !loginResponse.isError!) {
  	updateToken(loginResponse.data?.apiKey);
  	Get.offAllNamed(Routes.BOTTOMBAR);
	} else {
  	errorMessage.value = loginResponse?.message ?? "Autentikasi gagal";
  	Get.snackbar(
      	"Error",
    	"Autentikasi gagal: ${loginResponse?.message}",
    	snackPosition: SnackPosition.TOP,
    	backgroundColor: Colors.white,
  	);
	}

	isLoading.value = false;
  }

  void updateToken(String? apiKey) {
	if (apiKey != null) {
  	TOKEN = apiKey;
  	defaultHeader['Authorization'] = TOKEN;
  	USERNAME = txtUsername.value.text;
  	defaultHeader['username'] = USERNAME;
  	PASSWORD = txtPassword.value.text;
  	defaultHeader['password'] = PASSWORD;
	}
  }

  final count = 0.obs;

  @override
  void onInit() {
	super.onInit();
  }

  @override
  void onReady() {
	super.onReady();
  }

  @override
  void onClose() {
	super.onClose();
  }

  void increment() => count.value++;
}

