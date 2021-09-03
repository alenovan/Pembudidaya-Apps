
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart' as fltr;
class menu_list_item extends StatelessWidget {

  const menu_list_item({
    Key key,
    @required this.label,
    @required this.image,
    @required this.color,
    this.onTap,
  }) : super(key: key);

  final String label;
  final Color color;
  final ImageProvider image;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.height;
    ScreenUtil.instance = ScreenUtil();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 15,
      shadowColor: Colors.black26,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              flex: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      // textAlign: TextAlign.center,
                      text: TextSpan(
                        style: subtitle2,
                        children: [
                          TextSpan(
                            text: 'Panen',
                            style: subtitle2.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colorPrimary,
                              fontSize: 18.sp
                            ),
                          ),
                          TextSpan(
                            text: 'Ikan',
                            style: subtitle2.copyWith(
                              fontWeight: FontWeight.w400,
                              color: colorPrimary,
                                fontSize: 18.sp
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      label,
                      style: subtitle2.copyWith(color: greyTextColor,fontSize:  12.sp),
                    )
                  ],
                ),
              ),
            ),
        Expanded(
          flex: 45,
          child: ClipPath(

            clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10)),
                )),
            child: Image(
              image: image,
            ),
          )),
          ],
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0.0);
    path.lineTo(size.width - 10, 0.0);
    path.quadraticBezierTo(size.width, 0, size.width, 10);
    path.lineTo(size.width, size.height - 10);
    path.quadraticBezierTo(
        size.width, size.height, size.width - 10, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}