import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/DetailLelangView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/LelangHistory.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LoadingDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lelenesia_pembudidaya/src/bloc/LelangBloc.dart' as lelang;
import 'package:shimmer/shimmer.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart' as fltr;
class WinnerBidder extends StatefulWidget {
  final String idBidder;
  final String idLelang;
  final String idKolam;
  const WinnerBidder({Key key, this.idBidder, this.idLelang, this.idKolam}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<WinnerBidder> {
  var _name="null",_phone="null",_price="null",_alamat="null",_id_bid="null";
  final formatter = new NumberFormat('#,##0', 'ID');
  void fetchData() async{
    var data = await lelang.bloc.getBidderDetail(widget.idBidder);
    print(data);
    setState(() {
      _id_bid = "LelangPanen-00-"+data['id'].toString();
      _name = data['name'].toString();
      _phone = "-";
      _price = "Rp.${formatter.format(int.parse(data['bid_price']))}";
      _alamat = "-";
    });
  }

  void setWinner() async{
    LoadingDialog.show(context);
    var status = await lelang.bloc.setWinnerlelang(widget.idBidder,widget.idLelang);
    if (status) {
      AppExt.popScreen(context);
      BottomSheetFeedback.show_success(context, title: "Selamat", description: "Pemilihan pemenang berhasil");
      Timer(const Duration(seconds: 2), () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                // duration: Duration(microseconds: 1000),
                child: LelangHistory(
                  idKolam: widget.idKolam,
                )));
      });


    } else {
      AppExt.popScreen(context);
      BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali");
    }
  }
  @override
  void initState() {
    fetchData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ScreenUtil.instance = ScreenUtil();
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
            backgroundColor: Colors.white,
            drawer: Drawers(context),
            body: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 40.h,
                          left: SizeConfig.blockHorizotal * 5,
                          bottom: SizeConfig.blockHorizotal * 3,
                        ),
                        child: GestureDetector(
                            onTap: ()=>{
                              Navigator.of(context).pop()
                            },
                            child: Icon(Icons.arrow_back,
                                color: Colors.black,
                                size: 30.sp)),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              top: ScreenUtil()
                                  .setHeight(240)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                                child: Image.asset(
                                  "assets/png/dummy_profile.png",
                                  fit: BoxFit.cover,
                                )),

                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(70),
                        right: ScreenUtil().setWidth(70)),
                    child: Text(
                      "Kode Lelang",
                      style: subtitle1.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 20.sp),
                    )),
                Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(20),
                        left: ScreenUtil().setWidth(70),
                        right: ScreenUtil().setWidth(70)),
                    child: _id_bid != "null"?Text(
                      "${_id_bid}",
                      style: body2.copyWith(
                          fontSize: 20.sp),
                    ):Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.white,
                        child: Container(
                          height: 20.0,
                          width: ScreenUtil().setWidth(300),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                              BorderRadius.all(
                                  Radius.circular(
                                      16.0))),
                        ))),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(50),
                    bottom: ScreenUtil().setHeight(20),
                  ),
                  color: editTextField,
                  height: 0.5,
                ),
                Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(70),
                        right: ScreenUtil().setWidth(70)),
                    child: Text(
                      "Nama",
                      style: subtitle1.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 20.sp),
                    )),
                Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(20),
                        left: ScreenUtil().setWidth(70),
                        right: ScreenUtil().setWidth(70)),
                    child: _name != "null"?Text(
                      "${_name}",
                      style: body2.copyWith(
                          fontSize: 20.sp),
                    ):Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.white,
                        child: Container(
                          height: 20.0,
                          width: ScreenUtil().setWidth(300),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                              BorderRadius.all(
                                  Radius.circular(
                                      16.0))),
                        ))),
                Container(
                  margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(50),
                    bottom: ScreenUtil().setHeight(20),
                  ),
                  color: editTextField,
                  height: 0.5,
                ),
                Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(70),
                        right: ScreenUtil().setWidth(70)),
                    child: Text(
                      "Nomor Handphone",
                      style: subtitle1.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize:20.sp),
                    )),
                Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(20),
                        left: ScreenUtil().setWidth(70),
                        right: ScreenUtil().setWidth(70)),
                    child: _phone != "null"?Text(
                      "${_phone}",
                      style: body2.copyWith(
                          fontSize:20.sp),
                    ):Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.white,
                        child: Container(
                          height: 20.0,
                          width: ScreenUtil().setWidth(300),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                              BorderRadius.all(
                                  Radius.circular(
                                      16.0))),
                        ))),
                Container(
                  margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(50),
                    bottom: ScreenUtil().setHeight(20),
                  ),
                  color: editTextField,
                  height: 0.5,
                ),
                Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(70),
                        right: ScreenUtil().setWidth(70)),
                    child: Text(
                      "Harga",
                      style: subtitle1.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 20.sp),
                    )),
                Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(20),
                        left: ScreenUtil().setWidth(70),
                        right: ScreenUtil().setWidth(70)),
                    child: _price != "null"?Text(
                      "${_price}",
                      style: body2.copyWith(
                          fontSize: 20.sp),
                    ):Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.white,
                        child: Container(
                          height: 20.0,
                          width: ScreenUtil().setWidth(300),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                              BorderRadius.all(
                                  Radius.circular(
                                      16.0))),
                        ))),
                Container(
                  margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(50),
                    bottom: ScreenUtil().setHeight(20),
                  ),
                  color: editTextField,
                  height: 0.5,
                ),
                Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(70),
                        right: ScreenUtil().setWidth(70)),
                    child: Text(
                      "Alamat",
                      style: subtitle1.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize:20.sp),
                    )),
                Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(20),
                        left: ScreenUtil().setWidth(70),
                        right: ScreenUtil().setWidth(70)),
                    child: _alamat != "null"?Text(
                      "${_alamat}",
                      style: body2.copyWith(
                          fontSize: 20.sp),
                    ):Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.white,
                        child: Container(
                          height: 20.0,
                          width: ScreenUtil().setWidth(300),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                              BorderRadius.all(
                                  Radius.circular(
                                      16.0))),
                        ))),
                Container(
                  margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(50),
                    bottom: ScreenUtil().setHeight(20),
                  ),
                  color: editTextField,
                  height: 0.5,
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            )));
  }

  Future<bool> _onBackPressed() {

    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: LelangHistory(
              idKolam: widget.idKolam,
            )));
  }
}
