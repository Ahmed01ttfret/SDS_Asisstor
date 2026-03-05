import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sds_assistor/Pdf_Ai_Logics/Pdf_to_Text.dart';
import 'package:sds_assistor/Pdf_Ai_Logics/text_prompts.dart';

import '../../Pdf_Ai_Logics/Get_AI_response.dart';
import '../DataEntryPage.dart';



class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final ai = AiService(
    endpoint: "https://models.github.ai/inference",
    token: dotenv.get('sds_key'),
  model: "deepseek/DeepSeek-R1",
  );

  String _text='';

  void ssx()async{
    _text =await extractTextFromBytes(File['sds']!);
  }



  @override
  Widget build(BuildContext context) {


    return FutureBuilder(future: ai.sendMessage(Validating_sds(chemName, _text)), builder: (context,snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 50,),
            Text('Loading...')

          ],
        );
      }
      else if (snapshot.hasError) {

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded, color: Colors.red, size: 60,),
            Text('Something Went Wrong.', style: TextStyle(color: Colors.red),),
          ],
        );
      } else {
        return Text(snapshot.data!);
      }
    });
      }
    }



