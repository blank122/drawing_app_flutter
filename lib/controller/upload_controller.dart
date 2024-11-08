import 'dart:io';

import 'package:file_upload/constant/endpoints.dart';
import 'package:http/http.dart' as http;

class UploadController {
  Future<void> sendDrawingToServer(
      File file, Map<String, dynamic> answers) async {
    final url = Uri.parse("${baseUrl}upload");

    try {
      // Create a multipart request
      var request = http.MultipartRequest("POST", url);

      // Add other survey answers to the request
      answers.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Attach the drawing file
      var fileStream = await http.MultipartFile.fromPath('file', file.path);
      request.files.add(fileStream);

      // Send the request
      var response = await request.send();

      // Check the response
      if (response.statusCode == 200) {
        print("File uploaded successfully");
      } else {
        print("Failed to upload file. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error uploading file: $e");
    }
  }
}
