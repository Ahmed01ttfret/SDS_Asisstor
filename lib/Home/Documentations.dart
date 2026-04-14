import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

import '../Pdf_Ai_Logics/ReadTxt.dart';
import '../custom_widgets/CustomAppBar.dart';

class Documentations extends StatefulWidget {
  const Documentations({super.key});

  @override
  State<Documentations> createState() => _DocumentationsState();
}

class _DocumentationsState extends State<Documentations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Documentation'),
      body: FutureBuilder(future: readTxtFile('Documentation.txt'), builder: (context,snapshot){
        if(snapshot.hasData){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  GptMarkdown(snapshot.data!),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      }),

    );
  }
}