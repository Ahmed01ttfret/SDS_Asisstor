

import 'package:flutter/material.dart';

Widget Button1(VoidCallback callback, String text){
  return ElevatedButton(
    onPressed: callback,
    style: ButtonStyle(
      shape:  MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
          if (states.contains(MaterialState.hovered)) {
            return Colors.blue; // Darker blue
          }
          return Colors.white; // Normal blue
        },
      ),
      elevation: MaterialStateProperty.resolveWith<double>(
            (states) {
          if (states.contains(MaterialState.hovered)) {
            return 10;
          }
          return 3;
        },
      ),

    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    child: Text(text,),
    ),
  );
}