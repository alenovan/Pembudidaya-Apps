import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';

const String _fontPoppins = 'poppins';
const String _fontLato = 'lato';

// textSizeSmall = 12.0;
// textSizeSMedium = 14.0;
// textSizeMedium = 16.0;
// textSizeLargeMedium = 18.0;
// textSizeNormal = 20.0;
// textSizeLarge = 24.0;
// textSizeXLarge = 30.0;
// textSizeTitle = 34.0;

const TextStyle h1 = TextStyle(
  fontFamily: _fontPoppins,
  fontSize: 34.0,
  fontWeight: FontWeight.w700,
  color: textPrimary,
);

TextStyle h1Inv = h1.copyWith(color: textPrimaryInverted);
TextStyle h1Accent = h1.copyWith(color: textSecondary);



const TextStyle h2 = TextStyle(
  fontFamily: _fontPoppins,
  fontSize: 26.0,
  fontWeight: FontWeight.w700,
  color: textPrimary,
);

TextStyle h2Inv = h2.copyWith(color: textPrimaryInverted);
TextStyle h2Accent = h2.copyWith(color: textSecondary);

const TextStyle h3 = TextStyle(
  fontFamily: _fontPoppins,
  fontSize: 20.0,
  fontWeight: FontWeight.w500,
  color:textPrimary,
);

TextStyle h3Inv = h3.copyWith(color: textPrimaryInverted);
TextStyle h3Accent = h3.copyWith(color: textSecondary);

const TextStyle subtitle1 = TextStyle(
  fontFamily: _fontLato,
  fontSize: 18.0,
  fontWeight: FontWeight.w400,
  color: textPrimary,
);

TextStyle subtitle1Inv =
subtitle1.copyWith(color: textPrimaryInverted);
TextStyle subtitle1Accent = subtitle1.copyWith(color: textSecondary);

const TextStyle subtitle2 = TextStyle(
  fontFamily: _fontPoppins,
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  color: textPrimary,
);

TextStyle subtitle2Inv =
subtitle2.copyWith(color: textPrimaryInverted);
TextStyle subtitle2Accent = subtitle2.copyWith(color: textSecondary);

const TextStyle caption = TextStyle(
  fontFamily: _fontLato,
  fontSize: 13.0,
  fontWeight: FontWeight.normal,
  color: textPrimary,
);

TextStyle body1Inv = body1.copyWith(color: textPrimaryInverted);
TextStyle body1Accent = body1.copyWith(color: textSecondary);

const TextStyle body2 = TextStyle(
  fontFamily: _fontLato,
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  color: textPrimary,
);


TextStyle body2Inv = body2.copyWith(color: textPrimaryInverted);
TextStyle body2Accent = body2.copyWith(color: textSecondary);

const TextStyle button = TextStyle(
  fontFamily: _fontPoppins,
  fontSize: 16.0,
  fontWeight: FontWeight.w700,
  letterSpacing: 1.25,
);

TextStyle buttonInv = button.copyWith(color: textPrimaryInverted);
TextStyle buttonAccent = button.copyWith(color: textSecondary);

TextStyle captionInv = caption.copyWith(color: textPrimaryInverted);
TextStyle captionAccent = caption.copyWith(color: textSecondary);

const TextStyle body1 = TextStyle(
  fontFamily: _fontLato,
  fontSize: 18.0,
  fontWeight: FontWeight.w400,
  color: textPrimary,
);

const TextStyle overline = TextStyle(
  fontFamily: _fontLato,
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  color: textPrimary,
);

TextStyle overlineInv = overline.copyWith(color: textPrimaryInverted);
TextStyle overlineAccent = overline.copyWith(color: textSecondary);

const TextStyle tab = TextStyle(
  fontFamily: _fontPoppins,
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  color: textPrimary,
);

TextStyle tabInv = tab.copyWith(color: textPrimaryInverted);
TextStyle tabAccent = tab.copyWith(color: textSecondary);