
import 'package:electrocure_basic/connections/conn_consumption_logs.dart';
import 'package:flutter/material.dart';
import 'package:electrocure_basic/transformer/tr_List.dart';
import 'package:electrocure_basic/transformer/tr_consumptionlogs.dart';
import 'package:electrocure_basic/packages/login.dart';
import 'package:electrocure_basic/transformer/tr_dashboard.dart';
import 'package:electrocure_basic/transformer/tr_currentLogs.dart';
import 'package:electrocure_basic/distributionBoxes/DistributionBoxDashboard.dart';
import 'package:electrocure_basic/distributionBoxes/DistributionBoxesList.dart';
import 'package:electrocure_basic/distributionBoxes/db_currentLogs.dart';
import 'package:electrocure_basic/connections/conn.dart';
import 'package:electrocure_basic/connections/conn_current_logs.dart';
import 'package:electrocure_basic/outfeeders/ofd_dashboard.dart';
import 'package:electrocure_basic/Infeeder/ifd_dashboard.dart';
import 'package:electrocure_basic/Infeeder/ifd_list.dart';
import 'package:electrocure_basic/outfeeders/ofd_list.dart';
import 'package:electrocure_basic/Infeeder/ifd_current_log.dart';
import 'package:electrocure_basic/outfeeders/ofd_current_log.dart';
import 'package:electrocure_basic/Faults.dart';

void main() => runApp(
    //Wrap Material APP in Multiprovider Widget
    MaterialApp(
  title: 'Electrocure',
  theme: ThemeData(
    appBarTheme: AppBarTheme(
      color: Colors.blueGrey[400]
    ),
    dataTableTheme: DataTableThemeData(
      // headingRowColor:
      headingTextStyle: TextStyle(
          fontSize: 17, fontWeight: FontWeight.bold,
        color: Colors.black
      ),
      dataTextStyle: TextStyle(
          fontSize: 14,
          color: Colors.black
      )
    )
  ),
  initialRoute: '/',
  routes: {
    '/' : (context) => Login(),
    //transformer
    '/home' : (context) => Home(),    //transformer Dashboard
    '/tr_List' : (context) => TransformerList(),
    '/tr_currentlogs' : (context) =>CurrentLogs(),
    '/tr_consumptionLogs' : (context) => ConsumptionLogs(),

    //dbs
    '/db_Dashboard': (context) =>DistributionBoxesDashboard(),
    '/db_List' : (context) => DistributionBoxesList(),
    '/db_Current' : (context) => dbCurrentLogs(),
    //connections
    '/conn_List' :(context) => connectionList(),
    '/connCurrent' : (context) => connCurrentLogs(),
    '/connConsumption': (context) => conConsumptionLogs(),
    //outfeeder
    '/outfeeder' :(context) => ofd_dashboard(),
    '/ofd_List': (ctx) => Ofd_list(),
    '/ofdCurrentLog':(ctx) => Ofd_CurrentLogs(),

      //infeeder
    '/infeeder':(Context) => ifd_dashboard(),
    '/ifdList': (ctx) => Ifd_list(),
    'ifdCurrentLog':(ctx) => Ifd_CurrentLogs(),

    //faults
    '/faults':(ctx)=> Faults()
  },
));
