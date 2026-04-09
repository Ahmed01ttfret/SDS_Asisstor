

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sds_assistor/Pdf_Ai_Logics/text_prompts.dart';

import '../Tabs/DataEntryPage.dart';
import 'Get_AI_response.dart';

import 'dart:convert';

Map<String,String> info={};

Future<void> Upload() async {
  info={};
  final ai = AiService(

      apiKey: dotenv.get('gemini'),
      model: "gemini-3-flash-preview"
  );
  info=(await ai.uploadFile(bytes: File['sds']!, fileName: 'sds.pdf'))!;
}
Map<String, dynamic> extractJson(String response) {
  // Match ```json ... ``` or ``` ... ```
  final regex = RegExp(r'```(?:json)?\s*([\s\S]*?)```', multiLine: true);
  final match = regex.firstMatch(response);

  if (match != null) {
    String jsonString = match.group(1)!.trim();
    return jsonDecode(jsonString);
  }

  throw Exception("JSON not found");
}






ValueNotifier<Map<String, String>> data = ValueNotifier<Map<String, String>>({});

void check_if_sds()async{
  print(info);
  data.value['checking']='Loading';
  if(info.isNotEmpty || info['fileUri']!=null){
  final ai = AiService(

    apiKey: dotenv.get('gemini'),
      model: "gemini-3-flash-preview"
  );


  try {

    String? retured_tex = await ai.askAboutFile(fileUri: info['fileUri']!, mimeType: info["mimeType"]!, prompt: Validating_sds(chemName));
    retured_tex==null?data.value['checking']='error':data.value['checking'] = retured_tex;

  } catch(e){
    print(e);
    data.value['checking']='error';

  }}
  else{
    await Upload();
    check_if_sds();
  }
}







void Generate_Summery()async{
  if(data.value['checking']!='Loading' || data.value['checking']!='error'){
  data.value['summery']='Loading';
  final ai = AiService(

      apiKey: dotenv.get('gemini'),
      model: "gemini-3-flash-preview"
  );


  try {

    String?retured_tex = await ai.askAboutFile(fileUri: info['fileUri']!, mimeType: info["mimeType"]!, prompt: Summery_propt());
    retured_tex==null?data.value['summery']=='error':data.value['summery']=retured_tex;
    Generate_CheckList();
  } catch(e){
    print(e);
    data.value['summery']='error';

  }}
}





void Generate_CheckList()async{
  if(data.value['summery']!='Loading' || data.value['summery']!='error'){
    data.value['checklist']='Loading';
    final ai = AiService(

        apiKey: dotenv.get('gemini'),
        model: "gemini-3-flash-preview"
    );


    try {

      String?retured_tex = await ai.askAboutFile(fileUri: info['fileUri']!, mimeType: info["mimeType"]!, prompt: Hazard_action_prompt(description));
      retured_tex==null?data.value['checklist']=='error':data.value['checklist']=retured_tex;
    } catch(e){
      print(e);
      data.value['checklist']='error';

    }}
}


