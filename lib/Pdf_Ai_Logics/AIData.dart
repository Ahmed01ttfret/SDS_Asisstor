

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sds_assistor/Pdf_Ai_Logics/text_prompts.dart';

import '../Tabs/DataEntryPage.dart';
import 'Get_AI_response.dart';

import 'dart:convert';

Map<String, dynamic> extractJson(String response) {
  final regex = RegExp(r'```[\s\S]*?\{([\s\S]*?)\}[\s\S]*?```');
  final match = regex.firstMatch(response);

  if (match != null) {
    String jsonString = "{${match.group(1)!}}";
    return jsonDecode(jsonString);
  }

  throw Exception("JSON not found");
}




ValueNotifier<Map<String, String>> data = ValueNotifier<Map<String, String>>({});

void check_if_sds()async{
  data.value['checking']='Loading';
  final ai = AiService(
    endpoint: "https://models.github.ai/inference",
    token: dotenv.get('sds_key'),
    model: "deepseek/DeepSeek-R1",
  );


  try {
    data.value['checking']='Loading';
    final retured_tex = await ai.sendMessage(Validating_sds(chemName, text));
    data.value['checking']=retured_tex;
  } catch(e){
    data.value['checking']='error';

  }
}