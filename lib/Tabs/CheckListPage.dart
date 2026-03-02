

import 'package:flutter/material.dart';

import 'DataEntryPage.dart';

class Checklistpage extends StatefulWidget {
  const Checklistpage({super.key});

  @override
  State<Checklistpage> createState() => _ChecklistpageState();
}

class _ChecklistpageState extends State<Checklistpage> {
  @override
  Widget build(BuildContext context) {
    if(Data){
      return Column();
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