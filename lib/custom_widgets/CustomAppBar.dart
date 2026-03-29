


import 'package:flutter/material.dart';

AppBar CustomAppBar(String text){

  return AppBar(
    elevation: 4,
    toolbarHeight: 80,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(text),
        Image.asset('assets/logo1.png',
          width: 200,
        ),

      ],
    ),
  );
}