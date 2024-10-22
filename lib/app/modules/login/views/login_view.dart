import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
	final mediaSize = MediaQuery.of(context).size;

	return Scaffold(
  	body: Container(
    	decoration: BoxDecoration(
      	image: DecorationImage(
        	image: AssetImage("/icon/smk-min.jpg"),
        	fit: BoxFit.cover,
        	colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
      	),
    	),
    	child: Stack(
      	children: [
        	Positioned(top: 20, left: 0, right: 0, child: logo(mediaSize)),
        	Positioned(
          	bottom: 30,
          	left: 0,
          	right: 0,
          	child: Center(
            	child: loginBox(mediaSize, context),
          	),
        	),
      	],
    	),
  	),
	);
  }

  Widget logo(Size mediaSize) {
	double logoWidth = mediaSize.width * 0.6;
	double logoHeight = mediaSize.height * 0.3;

	return Center(
  	child: ConstrainedBox(
    	constraints: BoxConstraints(
      	maxWidth: logoWidth,
      	maxHeight: logoHeight,
      	minWidth: 100,
      	minHeight: 50,
    	),
    	child: FittedBox(
      	fit: BoxFit.contain,
      	child: Image(
        	image: AssetImage("/icon/logo.png"),
      	),
    	),
  	),
	);
  }

  Widget loginBox(Size mediaSize, BuildContext context) {
	return Center(
  	child: SizedBox(
    	width: mediaSize.width * 0.9,
    	child: Card(
      	shape: const RoundedRectangleBorder(
        	borderRadius: BorderRadius.only(
          	topLeft: Radius.circular(30),
          	topRight: Radius.circular(30),
          	bottomLeft: Radius.circular(30),
          	bottomRight: Radius.circular(30),
        	),
      	),
      	child: Padding(
        	padding: const EdgeInsets.all(32.0),
        	child: buildForm(context),
      	),
    	),
  	),
	);
  }

  Widget buildForm(BuildContext context) {
    	return Column(
  	crossAxisAlignment: CrossAxisAlignment.start,
  	children: [
    	Text(
      	"Username",
      	style: const TextStyle(color: Colors.grey),
    	),
    	Obx(() => buildInputField(controller.txtUsername.value, false)),
    	const SizedBox(height: 20),
    	Text(
      	"Password",
      	style: const TextStyle(color: Colors.grey),
    	),
    	Obx(() => buildInputField(controller.txtPassword.value, true)),
    	const SizedBox(height: 20),
    	buildLoginButton(),
  	],
	);
  }

  Widget buildInputField(TextEditingController textController, bool isPassword) {
	return TextField(
  	controller: textController,
  	decoration: InputDecoration(
    	suffixIcon: isPassword
      	? IconButton(
          	icon: Icon(
            	controller.isPasswordHidden.value ? Icons.visibility : Icons.visibility_off),
          	onPressed: () => controller.togglePasswordVisibility(),
        	)
      	: Icon(Icons.person),
  	),
  	obscureText: isPassword ? controller.isPasswordHidden.value : false,
	);
  }

 Widget buildLoginButton() {
	return Obx(() => controller.isLoading.value
  	? Center(child: CircularProgressIndicator())
  	: ElevatedButton(
      	onPressed: () => controller.authLogin(),
      	style: ElevatedButton.styleFrom(
        	backgroundColor: Colors.black,
                        	shape: const StadiumBorder(),
        	elevation: 20,
        	shadowColor: Colors.grey,
        	minimumSize: const Size.fromHeight(60),
      	),
      	child: const Text(
        	"LOGIN",
        	style: TextStyle(color: Colors.white),
      	),
    	),
	);
  }
}







