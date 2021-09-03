import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as fltr;
class LoginWidget extends StatelessWidget {
  const LoginWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

// ignore: non_constant_identifier_names
Widget RightLiquid(BuildContext context) {
  SizeConfig().init(context);
  final String assetName = "assets/svg/login/liquidright.svg";
  final Widget svgIcon = Container(
    child: SvgPicture.asset(
      assetName,
      width: SizeConfig.blockHorizotal * 40,
    ),
  );
  return svgIcon;
}

// ignore: non_constant_identifier_names
Widget LeftLiquid(BuildContext context) {
  SizeConfig().init(context);
  final String assetName = "assets/svg/login/liquidleft.svg";
  final Widget svgIcon = Container(
    child: SvgPicture.asset(
      assetName,
      width: SizeConfig.blockHorizotal * 40,
    ),
  );
  return svgIcon;
}

// ignore: non_constant_identifier_names
Widget Logo(BuildContext context,Color clr) {
  SizeConfig().init(context);
   String assetName = "";
  if(clr == Colors.white){
    assetName = "assets/svg/img_logo_white.svg";
  }else{
    assetName = "assets/svg/logo_placeholder.svg";
  }

  final Widget svgIcon = Container(
    child: Column(
      children: [
        SvgPicture.asset(
          assetName,
          height: ScreenUtil().setHeight(150),
        ),


        Container(
            padding: EdgeInsets.only(left: 10),
            child:  RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: 'Panen', style:TextStyle(
                      color: clr,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.75,
                      fontFamily: 'poppins',
                      fontSize: 15.0),),
                  TextSpan(text: 'Ikan',style: TextStyle(
                      color: clr,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'poppins',
                      letterSpacing: 0.75,
                      fontSize: 15.0),),
                ],
              ),
            )),
      ],
    ),
  );
  return svgIcon;
}

Widget LogoPanen(BuildContext context,Color clr ) {
  ScreenUtil.instance = ScreenUtil()..init(context);
  SizeConfig().init(context);
  var widget;
  String assetName = "";
  if(clr == Colors.white) {
    assetName = "assets/svg/logo_primary.svg";
    widget = SvgPicture.asset(
      assetName,
      width: ScreenUtil().setWidth(300),
    );
  }else if(clr == Colors.transparent){
    assetName = "assets/svg/logo_primary.svg";
    widget =  Image.asset(
      "assets/logo/white_logo.png",
      width: ScreenUtil().setWidth(300),
    );
  }else{
    assetName = "assets/svg/img_logo_panen.svg";
    widget = SvgPicture.asset(
      assetName,
      width: ScreenUtil().setWidth(300),
    );
  }
  final Widget svgIcon = Container(
    child: Column(
      children: [
        widget
      ],
    ),
  );
  return svgIcon;
}

// ignore: non_constant_identifier_names
InputDecoration EditTextDecorationNumber(BuildContext context, String label) {
  SizeConfig().init(context);
  final InputDecoration decoration = InputDecoration(
    isDense: true,
    contentPadding: EdgeInsets.only(left: 20.0,top:30),
    hintText: label,
    filled: true,
    prefixIcon: Container(
        transform: Matrix4.translationValues(0.0, -2.0, 0.0),
        width: 40.w,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "+62",
            style: TextStyle(
                color: greyTextColor,
                fontFamily: 'lato',
                letterSpacing: 0.25,
                fontSize: 15.sp),
          ),
        )),
    fillColor: editTextBgColor,
    hintStyle: TextStyle(
      color: greyIconColor,
        fontSize: 15.sp
    ),
    border: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(25.0),
      borderSide: BorderSide.none,
    ),
  );
  return decoration;
}

// ignore: non_constant_identifier_names
InputDecoration EditTextDecorationText(BuildContext context, String label,
    double leftx, double rightx, double topx, double bottomx) {
  SizeConfig().init(context);
  final InputDecoration decoration = InputDecoration(
    contentPadding: EdgeInsets.only(left: leftx, right: rightx,top:10.h,bottom:10.h),
    hintText: label,
    filled: true,

    fillColor: editTextBgColor,
    hintStyle: TextStyle(
      color: greyIconColor,
        fontSize: 15.sp
    ),
    border: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(25.0),
      borderSide: BorderSide.none,
    ),
  );
  return decoration;
}

// ignore: non_constant_identifier_names
InputDecoration EditTextPaswordDecoration(
    BuildContext context, String label, GestureDetector gs) {
  SizeConfig().init(context);
  final InputDecoration decoration = InputDecoration(
    contentPadding: const EdgeInsets.only(left: 20.0),
    hintText: label,
    filled: true,
    fillColor: editTextBgColor,
    hintStyle: TextStyle(
      color: greyIconColor,
    ),
    border: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(25.0),
      borderSide: BorderSide.none,
    ),
    suffixIcon: gs,
  );
  return decoration;
}
