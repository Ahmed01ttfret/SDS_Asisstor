

import 'package:flutter/material.dart';
import 'package:sds_assistor/Tabs/Checklistpage/Body.dart';

Widget Custom_Container(String category,String action_item,String priority){

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 2, // How much the shadow spreads
            blurRadius: 6, // How blurry the shadow is
            offset: Offset(0, 3), // Position of the shadow (x, y)
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(category,style: TextStyle(fontWeight: FontWeight.bold),),
                Spacer(),
                Text(priority,style: TextStyle(color: priority=='high'?Colors.red:priority=='medium'?Colors.orange:Colors.green),)
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(action_item),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Check the box once the above action has been completed',style: TextStyle(color: Colors.grey,fontSize: 12,),),
                Checkbox(
                  value: false, // a boolean variable
                  onChanged: (bool? value) {

                  },
                )
              ],
            ),
          )
        ],
      )
    ),
  );

}