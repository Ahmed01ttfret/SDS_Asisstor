

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sds_assistor/custom_widgets/Custom_Container.dart';

import '../../Pdf_Ai_Logics/AIData.dart';

Map<String,bool> validation_map={};

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

        if (value["checklist"] =='Loading') {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 50),
                Text('Loading...')
              ],
            ),
          );
        }

        else if (value["checklist"] =='error') {
          print(value["error"]);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline_rounded, color: Colors.red, size: 60),
                Text(
                  'Something Went Wrong.',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          );
        }
        else if(value['checklist']==null){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 50),
                Text('Waiting for SDS Verification')
              ]
            ),
          );
        }

        else {
          try {

            String cleanJson = value['checklist']!.replaceAll('```json', '').replaceAll('```', '').trim();
            final List<dynamic> decodedData = jsonDecode(cleanJson);

            return Column(
              children: [
                Container(
                  height: 70,
                  width: double.infinity,
                  color: Colors.blue,
                  child: Text('Decision will be shown here'),
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: decodedData.length,
                      itemBuilder: (context, index) => Custom_Container(decodedData[index]['category'], decodedData[index]['action_item'], decodedData[index]['priority'])),
                )

              ],
            );
          }catch(e){

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline_rounded,color: Colors.red,size: 60),
                  SizedBox(height: 20,),
                  Text('Something Went Wrong while reading json',style: TextStyle(color: Colors.red),),

                ],
              ),
            );
          }

        }
      },
    );
  }
}
