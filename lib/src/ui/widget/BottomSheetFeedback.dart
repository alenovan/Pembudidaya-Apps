import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart';
class BottomSheetFeedback {
  const BottomSheetFeedback();

  static Future show(BuildContext context,
      {String title, String description, IconData icon}) async {
    double _screenWidth = MediaQuery.of(context).size.width;
    hideKeyboard(context);
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 45),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: _screenWidth * (15 / 100),
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(7.5 / 2),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 55,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: h3Accent,
                ),
                Text(description,
                    textAlign: TextAlign.center, style: subtitle2)
              ],
            ),
          );
        });
    return;
  }


  static Future show_success(BuildContext context,
      {String title, String description, IconData icon}) async {
    double _screenWidth = MediaQuery.of(context).size.width;
    hideKeyboard(context);
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 45),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: _screenWidth * (15 / 100),
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(7.5 / 2),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Icon(
                  Icons.check_circle_outline,
                  color: colorPrimary,
                  size: 55,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: h3Accent,
                ),
                Text(description,
                    textAlign: TextAlign.center, style: subtitle2)
              ],
            ),
          );
        });
    return;
  }
}