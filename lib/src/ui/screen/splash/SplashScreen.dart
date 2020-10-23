import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/bloc/LoginBloc.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  void getToken() async {
    var token = await bloc.getToken();
    if (token != "") {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: DashboardView()));

    } else {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: LoginView()));

    }
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colorPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                SvgPicture.asset(
                  "assets/svg/img_logo_white.svg",
                  width: _screenWidth * (35 / 100),
                ),
                SizedBox(
                  height: 25,
                ),
                Text("Lelenesia", style: h1Inv),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.5,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text("lelenesia.panen-panen.com", style: body2Inv),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
