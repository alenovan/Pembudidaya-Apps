import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/riwayat/RiwayatPakan.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/TambahKolamView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/ProfileScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:page_transition/page_transition.dart';

class ImagesSvg extends StatelessWidget {
  const ImagesSvg({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

Widget DetailNull(BuildContext context) {
  SizeConfig().init(context);
  final String assetName = "assets/png/nullfishing.png";
  final Widget svgIcon = Container(
    child: Image.asset(
      assetName,
      width: SizeConfig.blockHorizotal * 50,
    ),
  );
  return svgIcon;
}

Widget OtpImage(BuildContext context) {
  SizeConfig().init(context);
  final String assetName = "assets/png/otpimage.jpg";
  final Widget svgIcon = Container(
    child: Image.asset(
      assetName,
      width: SizeConfig.blockHorizotal * 50,
    ),
  );
  return svgIcon;
}
