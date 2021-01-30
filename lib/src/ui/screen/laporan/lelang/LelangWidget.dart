import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:page_transition/page_transition.dart';

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
    height: ScreenUtil().setHeight(250),
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
                    style: subtitle2.copyWith(color: colorPrimary, fontSize: ScreenUtil(allowFontScaling: false)
                        .setSp(40),fontWeight: FontWeight.bold),
                  )),
              Container(
                  alignment: align,
                  child: Text(
                    sub,
                    style: h1.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.15,
                        fontSize: ScreenUtil(allowFontScaling: false)
                            .setSp(80)),
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
                  style: caption.copyWith(color:colorPrimary, fontSize: ScreenUtil(allowFontScaling: false)
                      .setSp(40)),
                ),
                Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: number,
                            style: h3.copyWith( fontSize: ScreenUtil(allowFontScaling: false)
                                .setSp(70)),
                          ),
                          TextSpan(
                            text: "  "+satuan,
                            style: overline,
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

    height: ScreenUtil().setHeight(250),
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
                              color: Colors.grey, fontSize: ScreenUtil(allowFontScaling: false).setSp(38)),
                        )),
                    Container(
                        child: Text(
                          title,
                          style: subtitle2.copyWith(
                              color: Colors.black, fontSize: ScreenUtil(allowFontScaling: false).setSp(48)),
                        ))
                  ],
                ),
                Container(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(45)),
                    alignment: Alignment.center,
                    child: Text(
                      number,
                      style: subtitle2.copyWith(
                          color: greyIconColor, fontSize: ScreenUtil(allowFontScaling: false).setSp(50),fontWeight: FontWeight.bold),
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
    height: ScreenUtil().setHeight(250),
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
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
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
                            color: Colors.grey, fontSize: ScreenUtil(allowFontScaling: false).setSp(38)),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: Text(
                            title,
                            style: subtitle2.copyWith(
                                color: Colors.black, fontSize: ScreenUtil(allowFontScaling: false).setSp(48)),
                          ))
                    ],
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      child:  Icon(
                        FontAwesomeIcons.chevronCircleRight,
                        color: purpleTextColor,
                        size: ScreenUtil().setHeight(70),
                      ))
                ],
              )),
        )),
  );
  return svgIcon;
}