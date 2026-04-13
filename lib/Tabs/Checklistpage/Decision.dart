

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:sds_assistor/Pdf_Ai_Logics/AIData.dart';

import 'Body.dart';

class Decision extends StatefulWidget {
  const Decision({super.key});

  @override
  State<Decision> createState() => _DecisionState();
}

class _DecisionState extends State<Decision> {
  double _height=100;
  bool read_more=false;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ValueListenableBuilder(
        valueListenable: validation_map,builder:(context,value,child){
          String message='### Fill checklist';
          String cleanJson = data.value['checklist']!.replaceAll('```json', '').replaceAll('```', '').trim();
          final List<dynamic> decodedData = jsonDecode(cleanJson);
          if(value.isNotEmpty){
            message=validatelist(decodedData)!;
          }

          return AnimatedContainer(duration: Duration(milliseconds: 200),
          height: _height,
          clipBehavior:  Clip.hardEdge,
            curve: Curves.easeInOut,


            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Checklist Verification',style: TextStyle(fontWeight: FontWeight.bold)),
                    TextButton(onPressed: (){

                      if(read_more){
                        setState(() {
                          _height=100;
                          read_more=!read_more;
                        });

                      }else{
                        setState(() {
                          _height=400;
                          read_more=!read_more;
                        });
                      }
                    }, child: Text(read_more?'Read less':'Read more',style: TextStyle(color: Colors.blue),))
                  ],
                ),
              ),
              GptMarkdown(read_more?message:message.substring(0,35)),
            ],

          ),

        );
        }
      ),
    );
  }
}

String? validatelist(List data){
  Iterable<bool> vals=validation_map.value.values;
  if(!vals.contains(true)){
    return '''
    
    ### Work Cannot Proceed

The checklist has not yet been completed. All required items must be properly filled and verified before any work begins.

**High-risk hazards must be identified, assessed, and adequately controlled prior to proceeding with the task.**
    ''';
  }else if(!vals.contains(false)){
    return '''
    ### Proceed With Work

All checklist items have been completed and verified. Work may now proceed.

Actions must be properly carried out **before** ticking each checkbox. The checklist must **not** be treated as a mere formality.

A **supervisor must review the checklist thoroughly** to ensure that all safety requirements are satisfied and that conditions are safe before work begins.
    
    ''';

  }else{
    int total =data.length;
    int checked=vals.where((x)=>x==true).length;
    if(total-checked<3){
      List index=[];
      for(int i=0;i<data.length;i++){
        if(validation_map.value[i]==false){
          index.add(i);

      }
      }
      for(int xx in index){
        if(data[xx]['priority']=='high'){

          return '''
          ### Work Suspended — Immediate Attention Required

Some **high-risk hazards** remain unresolved. Continuing work under these conditions presents a significant safety risk.

Work must remain suspended until all high-risk hazards have been properly controlled and verified.
          
          ''';
        }else{
          return '''
          ### Proceed With Caution

Some **low and medium-risk hazards** are still present. Although work may continue, prolonged exposure to these conditions may increase the risk of injury.

All remaining checklist items should be completed as soon as possible. Work should only proceed before completion in **critical situations** where delay is not feasible.
          
          ''';
        }
      }

    }else{
      return '''
        ### Work Cannot Proceed — Immediate Action Required

More than **three hazards** have been left unattended. Proceeding with work in this condition creates a high likelihood of unsafe outcomes.

All identified hazards must be resolved and verified before any work activities can continue.
      ''';
    }


  }
}

