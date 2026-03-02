


import 'dart:typed_data';

import 'package:pdfrx/pdfrx.dart';

import 'package:flutter/material.dart';

import '../Tabs/DataEntryPage.dart';




void Preview_Pdf(BuildContext context){
  // Place this in your State class
  ValueNotifier<String> file = ValueNotifier<String>('sds');

  showDialog(context: context,
      barrierDismissible: false,
      builder: (context){

    return Dialog(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 20,),


             ValueListenableBuilder(valueListenable: file, builder: (context,value,child) {
               return Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
               TextButton(onPressed: () {
                 file.value = 'sds';
               }, child: Text('SDS',
                 style: TextStyle(color:Colors.blue,letterSpacing:1,fontWeight: FontWeight.w100,decoration: value=='sds'?TextDecoration.underline:TextDecoration.none)),)
               ,
               TextButton(onPressed: (){

               file.value='emergency';
               }, child: Text('Emergency',style: TextStyle(color:Colors.blue,letterSpacing:1,fontWeight: FontWeight.w100,decoration: value=='emergency'?TextDecoration.underline:TextDecoration.none),)),
               ]

               );
             }
        ),



              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.close,size: 40,)),

            ],
          ),
          Expanded(
            child: SizedBox(
              width: 800,
                height: 800,
                child: ValueListenableBuilder<String>(
                  valueListenable: file,
                  builder: (context, bytes, child) {
                    // If bytes are null, show a placeholder or empty state


                    // Return your PdfViewer with the current 'bytes' value
                    return bytes=='sds'?SDS():Emergency();
                  },
                )
            ),
          ),
          SizedBox(height: 10,)
        ],
      )
    );
  });
}


Widget SDS(){
  return PdfViewer.data(File['sds']!, sourceName: 'sds.pdf');
}

Widget Emergency(){
  return PdfViewer.data(File['emergency']!, sourceName: 'emergency.pdf');
}