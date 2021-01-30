import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/EmptyAppBar.dart';
import 'package:page_transition/page_transition.dart';

class AcceptanceDialog extends StatelessWidget {
  const AcceptanceDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

Widget Alertquestion(BuildContext context, Widget success) {
  final Widget data = Container(
    child: Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Apakah Anda Yakin ? ",
              style: TextStyle(
                  color: blackTextColor,
                  fontFamily: 'poppins',
                  letterSpacing: 0.25,
                  fontSize: 15.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 35.0,
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockVertical * 1,
                        right: SizeConfig.blockVertical * 1,
                        top: SizeConfig.blockVertical * 3),
                    child: CustomElevation(
                        height: 35.0,
                        child: RaisedButton(
                          highlightColor: colorPrimary,
                          //Replace with actual colors
                          color: colorPrimary,
                          onPressed: () => {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    // duration: Duration(microseconds: 1000),
                                    child:success))
                          },
                          child: Text(
                            "Ya",
                            style: TextStyle(
                                color: backgroundColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'poppins',
                                letterSpacing: 1.25,
                                fontSize: subTitleLogin),
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ))),
                Container(
                  height: 35.0,
                  margin: EdgeInsets.only(
                      left: SizeConfig.blockVertical * 1,
                      right: SizeConfig.blockVertical * 1,
                      top: SizeConfig.blockVertical * 3),
                  child: CustomElevation(
                      height: 35.0,
                      child: RaisedButton(
                        highlightColor: colorPrimary,
                        //Replace with actual colors
                        color: redTextColor,
                        onPressed: () => {
                          Navigator.pop(context,true)

                        },
                        child: Text(
                          "Tidak",
                          style: TextStyle(
                              color: backgroundColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'poppins',
                              letterSpacing: 1.25,
                              fontSize: subTitleLogin),
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
  return data;
}


showLoaderDialog(BuildContext context){
  AlertDialog alert=AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 15),child:Text("Silahkan Tunggu .." )),
      ],),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}


Widget AlertSuccess(BuildContext context, Widget success) {
  Widget data;
  data = Container(
    child: Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child:
        AnimatedOpacity(
          opacity: 1.0 ,
          duration: Duration(milliseconds: 100),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  child:Icon(
                    Icons.check_circle_outline,
                    color: purpleTextColor,
                    size: 100.0,
                  )
              ),
              Text(
                "Berhasil ",
                style: TextStyle(
                    color: purpleTextColor,
                    fontFamily: 'poppins',
                    letterSpacing: 0.25,
                    fontSize: 25.0),
              ),
            ],
          ),
        ),

      ),
    ),
  );
  return data;
}


Widget LoadingShow(BuildContext context) {
  final double _screenWidth = MediaQuery.of(context).size.width;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  return Scaffold(
    primary: true,
    appBar:  EmptyAppBar(),
    backgroundColor: Colors.white,
    body: Stack(
      children: [
        Center(
          child: SizedBox(
              width: _screenWidth * (35 / 100),
              height: _screenWidth * (35 / 100),
              child: CircularProgressIndicator(
                backgroundColor: textSecondaryInverted,
                valueColor:
                new AlwaysStoppedAnimation<Color>(colorPrimary),
                strokeWidth: 2,
              )),
        ),
        Center(
          child: SvgPicture.asset(
            "assets/svg/logo_placeholder.svg",
            width: _screenWidth * (25 / 100),
          ),
        ),
      ],
    ),
  );
}




