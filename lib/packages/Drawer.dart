import 'package:flutter/material.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    Size siz=MediaQuery.of(context).size;
    return MultiLevelDrawer(
      subMenuBackgroundColor: Colors.grey[200],
      header: Container(
        child: Center(child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50,),
              Image.asset("assets/logo.png",width: 110,height: 110,),
              SizedBox(height: 4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("ECTRO",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  Text("CURE(Basic)",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
                ],
              ),
            ],
          ),
        ),),
      ),
      children: [
        MLMenuItem(
            trailing: Icon(Icons.arrow_right),
            subMenuItems: [
              MLSubmenu(submenuContent: Text("Infeeder Dashboard"),onClick: (){
                Navigator.pushNamed(context,'/infeeder');
              }),
              MLSubmenu(submenuContent: Text("Infeeder List"),onClick: (){
                Navigator.pushNamed(context,'/ifdList');
              }),
              MLSubmenu(submenuContent: Text("Infeeder Current Logs"),onClick: (){
                Navigator.pushNamed(context,'ifdCurrentLog');
  }),
            ],
            content:
            Text("Infeeder",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),onClick: (){
          Navigator.pushNamed(context, '/infeeder');
        }),
        MLMenuItem(
            trailing: Icon(Icons.arrow_right),
            subMenuItems: [
              MLSubmenu(submenuContent: Text("Outfeeder Dashboard"),onClick: (){
                Navigator.pushNamed(context,'/outfeeder',arguments: {
                'url1': "http://uetpswr.cisnr.com/electrocure/app/outfeeder.php",
                'args': ""
                });
              }),
              MLSubmenu(submenuContent: Text("Outfeeder List"),onClick: (){
                Navigator.pushNamed(context,'/ofd_List');
              }),
              MLSubmenu(submenuContent: Text("Outfeeder Current Logs"),onClick: (){
                Navigator.pushNamed(context,'/ofdCurrentLog');
              }),
            ],
            content:
            Text("Outfeeder",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),onClick: (){
              Navigator.pushNamed(context,'/outfeeder',arguments: {
              'url1': "http://uetpswr.cisnr.com/electrocure/app/outfeeder.php",
                'args': ""});
        }),
        MLMenuItem(
            trailing: Icon(Icons.arrow_right),
            subMenuItems: [
              MLSubmenu(submenuContent: Text("Transformers Dashboard"),onClick: (){
                Navigator.pushNamed(context,'/home',arguments: {
                  'args': ""
                });
              }),
              MLSubmenu(submenuContent: Text("Transformers List"),onClick: (){
                Navigator.pushNamed(context,'/tr_List');
              }),
              MLSubmenu(submenuContent: Text("Transformer Current Logs"),onClick: (){
                Navigator.pushNamed(context,'/tr_currentlogs');
              }),
              MLSubmenu(submenuContent: Text("Transformer Consumption Logs"),onClick: (){
                Navigator.pushNamed(context,'/tr_consumptionLogs');
              }),
            ],
            content:
            Text("Transformer",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),onClick: (){
          Navigator.pushNamed(context, '/');
        }),
        MLMenuItem(
            trailing: Icon(Icons.arrow_right),
            subMenuItems: [
              MLSubmenu(submenuContent: Text("Distribution Box Dashboard"),onClick: (){
                Navigator.pushNamed(context,'/db_Dashboard',arguments: {
                  'url1': "http://uetpswr.cisnr.com/electrocure/app/dblist.php",
                  'args': ""
                });
              }),
              MLSubmenu(submenuContent: Text("Distribution Boxes List"),onClick: (){
                Navigator.pushNamed(context,'/db_List');
              }),
              MLSubmenu(submenuContent: Text("Distribution Boxes Current"),onClick: (){
                Navigator.pushNamed(context,'/db_Current');
              }),
            ],
            content:
            Text("Distribution Boxes",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),onClick: (){
          Navigator.pushNamed(context, '/db_Dashboard');
        }),
        MLMenuItem(
            trailing: Icon(Icons.arrow_right),
            subMenuItems: [
              MLSubmenu(submenuContent: Text("Connection List"),onClick: (){
                Navigator.pushNamed(context,'/conn_List',arguments: {
                  'args': ""
                });
              }),
              MLSubmenu(submenuContent: Text("Customer Current Logs"),onClick: (){
                Navigator.pushNamed(context,'/connCurrent');
              }),
              MLSubmenu(submenuContent: Text("Customer Consumption Logs"),onClick: (){
                Navigator.pushNamed(context,'/connConsumption');
              }),
            ],
            content:
            Text("Connections",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),onClick: (){
          Navigator.pushNamed(context, '/conn_List');
        }),
        MLMenuItem(content: Text("Faults",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)), onClick: (){
          Navigator.pushNamed(context,'/faults');
        }),
        MLMenuItem(content: Text("logout",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)), onClick: (){
          Navigator.pushReplacementNamed(context, '/');
        }),
      ],
    );
  }
}