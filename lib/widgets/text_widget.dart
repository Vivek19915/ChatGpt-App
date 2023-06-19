import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget  TextWidget({String ? label,fontSize,color,fontWeight}){
  // return Text(
  //   label,
  //   // textAlign: TextAlign.justify,
  //   style: TextStyle(
  //     color: color ?? Colors.white,
  //     fontSize: fontSize,
  //     fontWeight: fontWeight ?? FontWeight.w500,
  //   ),
  // );


  //color(color ?? Colors.white)----> if color given by user then color else white color
  return label!.text.color(color ?? Colors.white).size(fontSize).fontWeight(fontWeight ?? FontWeight.w500 ).make();
}

