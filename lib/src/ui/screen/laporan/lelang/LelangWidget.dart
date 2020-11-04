import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';

class LelangWidget extends StatelessWidget {
  const LelangWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

Widget CardColumnLelang(BuildContext context, String title, String sub,Alignment align,double left) {
  final Widget svgIcon = Container(
    height: 100,
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
                    style: subtitle2.copyWith(color: colorPrimary),
                  )),
              Container(
                  alignment: align,
                  child: Text(
                    sub,
                    style: h1.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.15),
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
                  style: caption.copyWith(color:colorPrimary)
                ),
                Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: number,
                            style: h3.copyWith(fontSize: 28.0),
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
