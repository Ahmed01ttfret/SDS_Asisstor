

import 'package:flutter/material.dart';
import 'package:sds_assistor/Tabs/CheckListPage.dart';
import 'package:sds_assistor/Tabs/DataEntryPage.dart';
import 'package:sds_assistor/Tabs/SummeryPage.dart';
import 'package:sds_assistor/custom_widgets/Butt_1.dart';



class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int Selectedindex=0;
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    final List<Widget> pages=[
      DataEntryPage(),
      Summerypage(),
      Checklistpage()
    ];
    return Scaffold(
      appBar: width>600?AppBar(
        elevation: 4,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/logo1.png',
              width: 200,
            ),
            Row(

              children: [
              Button1((){}, 'Documentations'),
              SizedBox(width: 20,),
              Button1((){}, 'About'),
            ],)
          ],
        ),
      ):AppBar(
        elevation: 4,

        title: Center(child:Image.asset('assets/logo1.png',width: 160,)),

      ),
      drawer: width<600?Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
              child: Image.asset('assets/logo1.png',width: 100,height: 100,),
            ),

            Button1((){}, 'Documentations'),
            SizedBox(height: 20,),
            Button1((){}, 'About')

          ],
        ),
      ):null,
      bottomNavigationBar: width<600?NavigationBar(
          selectedIndex: Selectedindex,
          onDestinationSelected: (index){
            setState(() {

              Selectedindex=index;
            });
          },
          destinations: [
        NavigationDestination(icon:Icon( Icons.home), label: 'Home'),
        NavigationDestination(icon:Icon( Icons.document_scanner), label: 'Summery'),
        NavigationDestination(icon: Icon(Icons.list), label: 'Safety Checklist')
      ]):null,
      body: width<600?pages[Selectedindex]:Row(
        children: [
          NavigationRail(
              labelType: NavigationRailLabelType.all,
              onDestinationSelected: (index){
                setState(() {
                  Selectedindex=index;
                });
              },
              destinations: [
          
            NavigationRailDestination(icon:Icon( Icons.home), label: Text('Home')),
            NavigationRailDestination(icon:Icon( Icons.document_scanner), label: Text('Summery')),
            NavigationRailDestination(icon: Icon(Icons.list), label: Text('Safety Checklist'))
          
          ], selectedIndex: Selectedindex),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: pages[Selectedindex])
        ],
      ),
    );
    }
  }


