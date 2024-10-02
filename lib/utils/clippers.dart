
import 'package:flutter/material.dart';

class RectDropCLipper extends CustomClipper{
  final path =Path();
  @override
  getClip(Size size) {

  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
  
}

class CustomBellCurveClipper extends CustomClipper<Path> {

  final double BellHeight;
  final double BellWidth;
  final double BorderRadiud;
  double XPosition;

  CustomBellCurveClipper( {super.reclip, required this.BellHeight, required this.BellWidth, required this.XPosition,required this.BorderRadiud,});


  @override
  Path getClip(Size size) {

    XPosition*=size.width;
    var path = Path();
    var bottomLineY= size.height-BellHeight;
    var midX= size.width/2;
    var cubicStartX = XPosition-(BellWidth/2);
    var leftCubicDelta = XPosition -cubicStartX;
    var cubicEnd = XPosition+leftCubicDelta;
    path.moveTo(0, bottomLineY-BorderRadiud);
    path.quadraticBezierTo(0, bottomLineY, BorderRadiud, bottomLineY);
    path.lineTo(cubicStartX, bottomLineY);


    // path.quadraticBezierTo(,,);
    // path.quadraticBezierTo(
    //   size.width / 2, size.height+30,
    //   size.width/2+50, bottomLineY,
    // );
    // path.moveTo(x, bottomLineY+)
    // path.quadraticBezierTo(midX-30, bottomLineY+15, midX-20, bottomLineY+20);
    path.cubicTo(cubicStartX+leftCubicDelta/2, bottomLineY, cubicStartX+leftCubicDelta/2,size.height, XPosition,size.height);
    path.cubicTo(XPosition+leftCubicDelta/2, size.height, cubicEnd-leftCubicDelta/2,bottomLineY, cubicEnd,bottomLineY);
    path.lineTo(size.width-BorderRadiud, bottomLineY);
    path.quadraticBezierTo(size.width, bottomLineY, size.width, bottomLineY-BorderRadiud);
    path.lineTo(size.width, BorderRadiud);
    path.quadraticBezierTo(size.width, 0, size.width-BorderRadiud, 0);
    path.lineTo(BorderRadiud, 0);
    path.quadraticBezierTo(0, 0, 0, BorderRadiud);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class BellCurveClipper extends CustomClipper<Path> {


  @override
  Path getClip(Size size) {
    var path = Path();
    var bottomLineY= size.height*0.75;
    var midX= size.width/2;
    var cubicStartX = size.width*0.75;
    var leftCubicDelta = midX -cubicStartX;
    var cubicEnd = midX+leftCubicDelta;
    path.moveTo(0, bottomLineY);
    path.lineTo(cubicStartX, bottomLineY);


    // path.quadraticBezierTo(,,);
    // path.quadraticBezierTo(
    //   size.width / 2, size.height+30,
    //   size.width/2+50, bottomLineY,
    // );
    // path.moveTo(x, bottomLineY+)
    // path.quadraticBezierTo(midX-30, bottomLineY+15, midX-20, bottomLineY+20);
    path.cubicTo(cubicStartX+leftCubicDelta/2, bottomLineY, cubicStartX+leftCubicDelta/2,size.height, midX,size.height);
    path.cubicTo(midX+leftCubicDelta/2, size.height, cubicEnd-leftCubicDelta/2,bottomLineY, cubicEnd,bottomLineY);

    path.lineTo(size.width, bottomLineY);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
