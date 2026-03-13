
import 'dart:math';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sds_assistor/Pdf_Ai_Logics/AIData.dart';
import 'package:sds_assistor/custom_widgets/Butt_1.dart';

import '../Pdf_Ai_Logics/Pdf_to_Text.dart';

bool Data=false;
String path='';
Map<String, Uint8List> File = {};
String chemName='';
String description='';
String text='';




class DataEntryPage extends StatefulWidget {
  const DataEntryPage({super.key});

  @override
  State<DataEntryPage> createState() => _DataEntryPageState();
}

class _DataEntryPageState extends State<DataEntryPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0D47A1),
              Color(0xFF4292E0),
              Color(0xFF90A8D6),
            ],
          ),
          ),
            child:Row(
            children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(width: width>800?500:300,child: Info(width,context),),
              ),
              ?width>800?Expanded(child: Transform.rotate(angle: 340*pi/180, child: Image.asset('back2.png',height: 600,width: 800,))):null,
            ]

          )
          ),
        ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('AI Assistance Notice',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Text("SDS Assistor uses artificial intelligence to summarize safety data and generate checklists. While designed to support safe decision-making, AI systems can make mistakes or misinterpret information.This tool is intended to assist trained personnel — not replace professional judgment, safety procedures, or regulatory requirements. Always review original SDS documents and follow your organization’s safety protocols before proceeding with work.")
          ],
        ),
      )],

    );
  }
}

Widget Info(double size,BuildContext context){
  return Column(
    children: [
      SizedBox(height: size>800?50:10,),
      Text('Simplify SDS, Make it accessible And Ensure Compliance',style: TextStyle(fontSize: size>800?40:20,fontWeight: FontWeight.bold,color: Colors.white),),
      SizedBox(height: 30,),
      Text('Effortlessly manage safety data sheets,ensure compliance and keep workplace safe with SDS Assistor.',style: TextStyle(color: Colors.white)),
      SizedBox(height: size>800?30:20),
      size>800?Row(
        children: [
          Button1((){
            showCustomDialog(context);
          }, 'Get Started'),
          SizedBox(width: 5,),
          Button1((){}, 'Learn More')
        ],
      ):Column(
        children: [

          Button1((){
            showCustomDialog(context);
          }, 'Get Started'),
          Text(''),
          Button1((){}, 'Learn More')
        ],
      )
    ],
  );
}



void showCustomDialog(BuildContext context) {
  final _formKey=GlobalKey<FormState>();
  final TextEditingController controller=TextEditingController();
  final TextEditingController controller2=TextEditingController();
  final TextEditingController controller3=TextEditingController();
  final TextEditingController controller4=TextEditingController();
  controller2.text='Optional';

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Record SDS Information", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Form(key: _formKey,child: Column(
                children: [
                  TextFormField(
                   controller: controller3,

                    decoration: InputDecoration(
                      labelText: 'Enter Name of Chemical',
                      border: OutlineInputBorder(),

                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter chemical name';
                      }
                      return null;
                    }

                  ),
                  SizedBox(height: 10),


                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'add SDS(.pdf file)',

                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please insert pdf file';
                              }
                              return null;
                            }
                        ),
                      ),

                      IconButton(onPressed: () async {
                        String nane =await pickPdf(1);
                        controller.text=nane;


                      }, icon: Icon(Icons.upload_file))
                    ],
                  ),
                  SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                            controller: controller2,
                            decoration: InputDecoration(
                              labelText: "Add Company's Emergency Response Procedure(.pdf file)",
                              border: OutlineInputBorder(),
                            ),

                        ),
                      ),

                      IconButton(onPressed: () async {
                        String name =await pickPdf(4);
                        controller2.text=name;

                      }, icon: Icon(Icons.upload_file))

                    ],
                  ),



                  SizedBox(height: 10),

                  TextFormField(
                    autocorrect: true,
                      maxLines: 5,
                      controller: controller4,
                      decoration: InputDecoration(

                        labelText: 'Enter a Brief job description',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter job description';
                        }
                        chemName=controller3.text;
                        description=controller4.text;
                        return null;
                      }
                  ),
                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: ()async{
                      if(_formKey.currentState!.validate()){
                        Navigator.pop(context);

                        Data=true;
                        text=await extractTextFromBytes(File['sds']!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Data Uploaded Successfully'))
                        );
                        data.value={};
                        check_if_sds();
                      }
                      }, child: Text('Proceed')),
                      SizedBox(width: 10,),
                      ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text('Cancel'))
                    ],
                  )




                ],
              ))



            ],
          ),
        ),
      );
    },
  );
}




Future<String> pickPdf(int i) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    withData: true,
    allowedExtensions: ['pdf'],
  );

  if (result != null) {
    String filePath = result.files.single.name;
    Uint8List? selectedBytes = result.files.single.bytes;
    if(i==1){
      File['sds']=selectedBytes!;
    }else{
      File['emergency']=selectedBytes!;
    }
    return "$filePath";

    // You can now upload or store this file
  } else {
    return '';
  }
}