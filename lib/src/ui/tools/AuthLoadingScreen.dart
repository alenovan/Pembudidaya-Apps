import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';

class AuthLoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
}