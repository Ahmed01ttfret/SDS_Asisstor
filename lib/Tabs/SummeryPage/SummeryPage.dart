import 'package:flutter/material.dart';
import 'package:sds_assistor/Tabs/SummeryPage/Body.dart';
import 'package:sds_assistor/custom_widgets/Butt_1.dart';

import '../../Pdf_Ai_Logics/Pdf_to_Text.dart';
import '../../custom_widgets/Preview_PDF.dart';
import '../DataEntryPage.dart';

class Summerypage extends StatefulWidget {
  const Summerypage({super.key});

  @override
  State<Summerypage> createState() => _SummerypageState();
}

class _SummerypageState extends State<Summerypage> {
  @override
  Widget build(BuildContext context) {
    if(Data){
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Summery Of SDS',style: TextStyle(fontWeight: FontWeight.bold),),
                Button1(()async{
                  Preview_Pdf(context);

                }, 'Preview Original Files'),

              ],
            ),
          ),
          Expanded(child: Body())
        ],
      );
    }else{
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded,color: Colors.red,size: 60,),
            Text('No data available'),
          ],
        ),
      );

    }
  }
}
