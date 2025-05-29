import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String imgbbApiKey = '1ebb2b41b5594e9e3032babfb588321e';

Future<String?> uploadToImgBB(File imageFile) async {
  final url = Uri.parse("https://api.imgbb.com/1/upload?key=$imgbbApiKey");
  final request = http.MultipartRequest('POST', url);
  request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
  final response = await request.send();
  final resBody = await response.stream.bytesToString();
  final jsonRes = jsonDecode(resBody);
  return jsonRes['data']['url'];
}
