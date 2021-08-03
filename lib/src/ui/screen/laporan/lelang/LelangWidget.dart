import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as fltr;
class LelangWidget extends StatelessWidget {
  const LelangWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

Widget CardColumnLelang(BuildContext context, String title, String sub,Alignment align,double left) {
  ScreenUtil.instance = ScreenUtil();
  final Widget svgIcon = Container(
    height: 100.h,
    width: double.infinity,
    child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: EdgeInsets.only(left: left),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: align,
                  child: Text(
                    title,
                    style: subtitle2.copyWith(color: colorPrimary, fontSize: 25.sp,fontWeight: FontWeight.bold),
                  )),
              Container(
                  alignment: align,
                  child: Text(
                    sub,
                    style: h1.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.15,
                        fontSize: 30.sp),
                  )),
            ],
          ),
        )),
  );
  return svgIcon;
}


Widget CardInfoLelang(
    BuildContext context, String title, String number, String satuan) {
  final Widget svgIcon = Container(
    child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: caption.copyWith(color:colorPrimary, fontSize: 20.sp),
                ),
                Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: number,
                            style: h3.copyWith( fontSize: 40.sp),
                          ),
                          TextSpan(
                            text: "  "+satuan,
                            style: overline.copyWith(fontSize: 20.sp),
                          ),
                        ]))),
              ],
            ))),
  );
  return svgIcon;


}

Widget LelangLeftRight(
    BuildContext context, String title, String number, String date) {
  ScreenUtil.instance = ScreenUtil();
  final Widget svgIcon = Container(

    height: 80.h,
    child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Text(
                          "${date}",
                          style: subtitle2.copyWith(
                              color: Colors.grey, fontSize: 15.sp),
                        )),
                    Container(
                        child: Text(
                          title,
                          style: subtitle2.copyWith(
                              color: Colors.black, fontSize: 20.sp),
                        ))
                  ],
                ),
                Container(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(45)),
                    alignment: Alignment.center,
                    child: Text(
                      number,
                      style: subtitle2.copyWith(
                          color: greyIconColor, fontSize: 18.sp,fontWeight: FontWeight.bold),
                    ))
              ],
            ))),
  );
  return svgIcon;
}

Widget CardLeftRightButton(
    BuildContext context, String title, String date,Widget next) {
  ScreenUtil.instance = ScreenUtil();
  final Widget svgIcon = Container(
    height: 94.h,
    child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          onTap: (){
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: next));
          },
          child: Container(
              padding: EdgeInsets.only(left: 10.w, right: 10.w,top: 10.h,bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: subtitle2.copyWith(
                            color: Colors.grey, fontSize: 20.sp),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: Text(
                            title,
                            style: subtitle2.copyWith(
                                color: Colors.black, fontSize: 25.sp),
                          ))
                    ],
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      child:  Icon(
                        FontAwesomeIcons.chevronCircleRight,
                        color: purpleTextColor,
                        size: 40.sp,
                      ))
                ],
              )),
        )),
  );
  return svgIcon;
}