import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sds_assistor/Pdf_Ai_Logics/PiecewisingText.dart';

class AiService {
  final String endpoint;
  final String token;
  final String model;

  List<Map<String, String>> _messages = [];

  AiService({
    required this.endpoint,
    required this.token,
    required this.model,
  }) {
    // Optional: Add a system instruction once
    _messages.add({
      "role": "system",
      "content":
      "You are an SDS (Safety Data Sheet) assistant specialized in chemical and environmental safety. Analyze and summarize safety documents with technical accuracy. Highlight hazards, risk levels, exposure controls, PPE requirements, emergency response measures, storage conditions, and environmental impacts. Prioritize clarity, compliance, and safety-critical information."
    });
  }

  Future<String> sendMessage(String userMessage) async {

    // Add user message to memory
    _messages=_messages+[Chunks(userMessage)[0]];

    final url = Uri.parse('$endpoint/chat/completions');



    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "model": model,
        "messages": _messages,
        "max_tokens": 800
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
          "AI request failed: ${response.statusCode} ${response.body}");
    }

    final data = jsonDecode(response.body);
    final aiReply = data['choices'][0]['message']['content'];

    // Store assistant reply in memory
    _messages.add({
      "role": "assistant",
      "content": aiReply,
    });

    return aiReply;
  }

  


  void clearMemory() {
    _messages.clear();
  }
}