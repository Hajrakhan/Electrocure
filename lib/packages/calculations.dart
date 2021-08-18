import 'package:flutter/material.dart';

var style1=   TextStyle(fontSize:12,color: Colors.black,fontWeight: FontWeight.w900);
var style2= TextStyle(fontSize:12,color: Colors.black,);
String totalcurrent(double c1,double c2,double c3){
  double c= c1+c2+c3;
  return c.toStringAsFixed(2);
}
//average voltage calculations
String avgvoltage(double v1,double v2,double v3){
  double v= (v1+v2+v3)/3;
  return v.toStringAsFixed(2);
}

//KVA Calculations
String KVA_cal(double c,double v){
  double kva=(c*v)/1000;
  return kva.toStringAsFixed(2);
}
