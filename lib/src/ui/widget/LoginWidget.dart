import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';

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
      height: SizeConfig.blockVertical * 29,
    ),
  );
  return svgIcon;
}

// ignore: non_constant_identifier_names
Widget Logo(BuildContext context) {
  SizeConfig().init(context);
  final String assetName = "assets/svg/logo_placeholder.svg";
  final Widget svgIcon = Container(
    child: SvgPicture.asset(
      assetName,
      height: SizeConfig.blockVertical * 10,
      width: SizeConfig.blockHorizotal * 10,
    ),
  );
  return svgIcon;
}

// ignore: non_constant_identifier_names
InputDecoration EditTextDecorationNumber(BuildContext context, String label) {
  SizeConfig().init(context);
  final InputDecoration decoration = InputDecoration(
    contentPadding: const EdgeInsets.only(left: 20.0),
    hintText: label,
    filled: true,
    prefixIcon: Container(
        width: 20.0,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "+62",
            style: TextStyle(
                color: greyTextColor,
                fontFamily: 'lato',
                letterSpacing: 0.25,
                fontSize: 17.0),
          ),
        )),
    fillColor: editTextBgColor,
    hintStyle: TextStyle(
      color: greyIconColor,
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
    contentPadding: EdgeInsets.only(left: leftx, right: rightx),
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
