

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sds_assistor/Tabs/Checklistpage/Decision.dart';
import 'package:sds_assistor/custom_widgets/Custom_Container.dart';

import '../../Pdf_Ai_Logics/AIData.dart';

ValueNotifier<Map<int, bool>> validation_map =ValueNotifier<Map<int, bool>>({});

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with AutomaticKeepAliveClientMixin{
  bool get wantKeepAlive => true;
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
                Decision(),
                SizedBox(height: 20,),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: decodedData.length,
                      itemBuilder: (context, index){
                      validation_map.value[index]=false;

                      return CustomContainer(category: decodedData[index]['category'], actionItem: decodedData[index]['action_item'], priority: decodedData[index]['priority'], index: index);

                      }),
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

