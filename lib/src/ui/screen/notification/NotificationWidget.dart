import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

Widget CardNotif(BuildContext context, String title, String sub) {
  final Widget svgIcon = Container(
    margin: EdgeInsets.only(
        left: SizeConfig.blockVertical * 2,
        top: SizeConfig.blockVertical * 1,
        right: SizeConfig.blockVertical * 2),
    height: 90,
    width: double.infinity,
    child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  child: Text(
                    title,
                    style: body1,
                  )),
              Container(
                  child: Text(
                    sub,
                    style: overline.copyWith(color:colorPrimary),
                  )),
            ],
          ),
        )),
  );
  return svgIcon;
}

