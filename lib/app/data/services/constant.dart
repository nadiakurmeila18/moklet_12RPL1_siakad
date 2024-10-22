import 'package:get/get.dart';

const String DOMAIN = 'http://51.79.136.232:12016';
const String DB_NAME = 'db_siakad';
String TOKEN = '0405f143-c1db-49bb-ab26-22e74977a869';
String USERNAME = 'admin';
String PASSWORD = '123456';
const String CORS_ANYWHERE = 'https://cors-anywhere.herokuapp.com/';
Rx<bool> IS_LOADING = false.obs;

Map<String, String> defaultHeader = {
  'Accept': '/',
  'Content-Type': 'application/json',
  'Connection': 'keep-alive',
  'Accept-Encoding': 'gzip',
};

addCookies() {
  final username = <String, String>{'username': USERNAME};
  final password = <String, String>{'password': PASSWORD};
  final authorization = <String, String>{'Authorization': TOKEN};
  defaultHeader.addEntries(username.entries);
  defaultHeader.addEntries(password.entries);
  defaultHeader.addEntries(authorization.entries);
}
