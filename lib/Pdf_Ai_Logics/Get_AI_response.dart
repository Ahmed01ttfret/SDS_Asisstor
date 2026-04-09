import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sds_assistor/Pdf_Ai_Logics/PiecewisingText.dart';






class AiService {
  final String apiKey;
  final String model;

  AiService({required this.apiKey, required this.model});

  /// --- Upload a byte array as a file ---
  /// Returns a map with fileUri, fileName, mimeType
  Future<Map<String, String>?> uploadFile({
    required Uint8List bytes,
    required String fileName,
    String mimeType = "application/pdf",
  }) async {
    try {
      var uploadUri = Uri.parse(
        "https://generativelanguage.googleapis.com/upload/v1beta/files?key=$apiKey",
      );

      var request = http.MultipartRequest("POST", uploadUri);

      request.files.add(
        http.MultipartFile.fromBytes(
          "file",
          bytes,
          filename: fileName,
          contentType: MediaType.parse(mimeType),
        ),
      );

      var response = await request.send();

      if (response.statusCode != 200) {
        print("Upload failed: ${response.statusCode}");
        return null;
      }

      var respStr = await response.stream.bytesToString();
      var jsonResp = json.decode(respStr);

      return {
        "fileUri": jsonResp["file"]["uri"],
        "fileName": jsonResp["file"]["name"],
        "mimeType": jsonResp["file"]["mimeType"] ?? mimeType,
      };
    } catch (e) {
      print("Error uploading file: $e");
      return null;
    }
  }

  /// --- Ask Gemini about an uploaded file ---
  /// Pass the file info returned from uploadFile
  Future<String?> askAboutFile({
    required String fileUri,
    required String mimeType,
    required String prompt,
  }) async {
    try {
      var generateUri = Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey",
      );

      var body = {
        "contents": [
          {
            "parts": [
              {"fileData": {"fileUri": fileUri, "mimeType": mimeType}},
              {"text": prompt}
            ]
          }
        ]
      };

      var response = await http.post(
        generateUri,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode != 200) {
        print("Generation failed: ${response.body}");
        return null;
      }

      var jsonResp = json.decode(response.body);

      return jsonResp["candidates"]?[0]?["content"]?["parts"]?[0]?["text"];
    } catch (e) {
      print("Error generating content: $e");
      return null;
    }
  }

  /// --- Delete an uploaded file ---
  Future<bool> deleteFile({required String fileName}) async {
    try {
      var uri = Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/files/$fileName?key=$apiKey",
      );

      var response = await http.delete(uri);

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Delete failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error deleting file: $e");
      return false;
    }
  }
}
