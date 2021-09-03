import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as fltr;
class LoginWidget extends StatelessWidget {
  const LoginWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

// ignore: non_constant_identifier_names
Widget AppbarForgot(BuildContext context, String title, Widget page,Color color) {
  SizeConfig().init(context);
  final Widget appBar = AppBar(
    brightness: Brightness.dark,
    toolbarHeight: 100.0,
    backgroundColor: color,
    elevation: 0.0,
    title: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: h3,
            ),
          ],
        )),
    leading: Container(
        margin: EdgeInsets.only(
            left: SizeConfig.blockHorizotal*5),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft, child: page));
            /* Write listener code here */
          },
          child: IconTheme(
            data: IconThemeData(color: appBarTextColor),
            child: Icon(Icons.arrow_back),
          ),
        )),
  );
  return appBar;
}

Widget TitleText(BuildContext context, String title, double sizex, double leftx,
    double rightx, double topx, double bottomx) {
  SizeConfig().init(context);
  final Widget titlex = Container(
    margin:
        EdgeInsets.only(left: leftx, right: rightx, top: topx, bottom: bottomx),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: h3,
        ),
      ],
    ),
  );
  ;
  return titlex;
}

// ignore: non_constant_identifier_names
Widget AppBarContainer(BuildContext context, String title, Widget page,Color color) {
  SizeConfig().init(context);
  final Widget appBar = Container(
    padding: EdgeInsets.only(top:SizeConfig.blockVertical*4,bottom:SizeConfig.blockVertical*2,),
    color: color,
    child: Row(
      children: [
        Container(
            margin: EdgeInsets.only(
              top: SizeConfig.blockHorizotal*3,
                left: SizeConfig.blockHorizotal*5),
            child: GestureDetector(
              onTap: () {
                if(page == null){
                  Navigator.of(context).pop(true);
                }else{
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft, child: page));
                }

                /* Write listener code here */
              },
              child: IconTheme(
                data: IconThemeData(color: appBarTextColor),
                child: Icon(Icons.arrow_back,size: 30.sp),
              ),
            )),
       Container(
         margin: EdgeInsets.only(
             top: SizeConfig.blockHorizotal*1,
             left: SizeConfig.blockHorizotal*5),
         child:  Text(
           title,
           style: h3,
         ),
       ),

      ],
    ),
  );
  return appBar;
}
