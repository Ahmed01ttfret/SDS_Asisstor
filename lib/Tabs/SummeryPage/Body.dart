import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:sds_assistor/Pdf_Ai_Logics/Map_to_markdown.dart';


import '../../Pdf_Ai_Logics/AIData.dart';


class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {


    return ValueListenableBuilder(
      valueListenable: data,
      builder: (context, value, child) {

        if (value["checking"] =='Loading') {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 50),
              Text('Loading...')
            ],
          );
        }

        else if (value["checking"] =='error') {
          print(value["error"]);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline_rounded, color: Colors.red, size: 60),
              Text(
                'Something Went Wrong.',
                style: TextStyle(color: Colors.red),
              ),
            ],
          );
        }

        else {
          Map<String,dynamic>dict= extractJson(value['checking']!);
          if(dict['chemical_match']){
            if(value['summery']=='error'){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline_rounded,color: Colors.red,size: 60),
                  SizedBox(height: 20,),
                  Text('Something Went Wrong.',style: TextStyle(color: Colors.red),),

                ],
              );

            }else if(value['summery']=='Loading'){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 50),
                  Text('Loading...')
                ],
              );
            }else if(value['summery']==null){
              Generate_Summery();
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 50),
                  Text('Loading...')
                ]
              );

            }
            else{
              try {

                Map<String, dynamic>summery = extractJson(value['summery']!);


                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        GptMarkdown(markDown(summery)),
                        SizedBox(height: 10,),

                      ],
                    ),
                  )
                );
              }catch(e){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline_rounded,color: Colors.red,size: 60),
                    SizedBox(height: 20,),
                    Text('Something Went Wrong while reading json',style: TextStyle(color: Colors.red),),

                  ]
                );
              }
            }

          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline_rounded,color: Colors.red,size: 60),
                SizedBox(height: 20,),
                Text(dict['reason'],style: TextStyle(color: Colors.red),),
              ],
            ),
          );

        }
      },
    );
      }
    }







