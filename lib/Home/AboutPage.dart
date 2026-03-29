



import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:sds_assistor/custom_widgets/CustomAppBar.dart';

import '../Pdf_Ai_Logics/ReadTxt.dart';

class Aboutpage extends StatefulWidget {
  const Aboutpage({super.key});

  @override
  State<Aboutpage> createState() => _AboutpageState();
}

class _AboutpageState extends State<Aboutpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('About Page'),
      body: AboutPageBody(),
    );
  }
}




class AboutPageBody extends StatefulWidget {
  const AboutPageBody({super.key});

  @override
  State<AboutPageBody> createState() => _AboutPageBodyState();
}

class _AboutPageBodyState extends State<AboutPageBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: readTxtFile('About.txt'), builder: (context,snapshot){
      if(snapshot.hasError){
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline_rounded,color: Colors.red,size: 60,),
              SizedBox(height: 10,),
              Text('Error Loading File')

            ],
          ),
        );
      }else if(snapshot.hasData){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                GptMarkdown(snapshot.data!),
                SizedBox(height: 10,),
                TextButton(onPressed: (){
                  showLicensePage(
                    context: context,
                    applicationName: "SDS Intelligent Assistant",
                    applicationVersion: "1.0.0",
                  );
                }, child: Text('View Licenses'))


              ],
            ),
          ),
        );

      }
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator()
            ,SizedBox(height: 10,),
            Text('Loading File')

          ],

        ),
      );
    });
  }
}


