import 'package:flutter/material.dart';

class HeadText extends Text{

  HeadText(super.data);


}
Widget headerText(String data){
  return  Text(data,style: const TextStyle(color: Colors.white),);
}