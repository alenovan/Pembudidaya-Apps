import 'dart:ffi';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/CheckoutFix.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/ChekoutReorder.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/PenentuanPakanView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/PenentuanPanenView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/LocalizedTimeFactory.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AcceptanceDialog.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AreaAndLineChart.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LoadingDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lelenesia_pembudidaya/src/bloc/KolamBloc.dart' as kolam;
class LaporanHomeWidget extends StatelessWidget {
  const LaporanHomeWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}



Widget CardColumn(BuildContext context, String title, String sub,
    Alignment align, double left) {
  final Widget svgIcon = Container(
    height: 100,
    width: double.infinity,
    child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: EdgeInsets.only(left: left),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: align,
                  child: Text(
                    title,
                    style: subtitle2.copyWith(color: colorPrimary),
                  )),
              Container(
                  alignment: align,
                  child: Text(
                    sub,
                    style: h3.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.15),
                  )),
            ],
          ),
        )),
  );
  return svgIcon;
}

Widget CardRow(BuildContext context, String title, String sub) {
  final Widget svgIcon = Container(
    height: 100,
    child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
            padding: EdgeInsets.only(
                left: SizeConfig.blockVertical * 3, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Text(
                      title,
                      style: subtitle2.copyWith(color: colorPrimary),
                    )),
                    Container(
                        child: Text(
                      sub,
                      style: h3.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.15),
                    )),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    alignment: Alignment.centerRight,
                    child: CustomElevation(
                        height: 40.0,
                        child: RaisedButton(
                          highlightColor: colorPrimary,
                          //Replace with actual colors
                          color: colorPrimary,
                          onPressed: () => {},
                          child: Text(
                            "Request",
                            style: overline.copyWith(color: Colors.white),
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ))),
              ],
            ))),
  );
  return svgIcon;
}

Widget buildCardChart(
    {@required String title,
    @required filter,
    @required int percent,
    @required int status,
    @required String statusCount,
    @required String date,
    @required chartData,
    @required context}) {
  print(filter);
  initializeDateFormatting();
  var statusData;
  if (status == 1) {
    statusData = Row(children: <Widget>[
      Icon(
        Icons.trending_up,
        size: 12.0,
      ),
      Text(
        " " + statusCount + "%",
        style: overline.copyWith(color: Colors.green),
      )
    ]);
  } else {
    statusData = Row(children: <Widget>[
      Icon(
        Icons.trending_down,
        color: Colors.red,
        size: 12.0,
      ),
      Text(
        " " + statusCount + "%",
        style: overline.copyWith(color: Colors.red),
      )
    ]);
  }
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
              left: SizeConfig.blockVertical * 2,
              top: SizeConfig.blockHorizotal * 1),
          child: Text(
            date,
            style: body2.copyWith(color: Colors.grey),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: SizeConfig.blockVertical * 3,
            bottom: SizeConfig.blockHorizotal * 3,
          ),
          width: double.infinity,
          height: 200,
          child: charts.TimeSeriesChart(
            chartData,
            animate: true,
            dateTimeFactory:
                LocalizedTimeFactory(Localizations.localeOf(context)),
            primaryMeasureAxis: new charts.NumericAxisSpec(
                tickProviderSpec:
                    new charts.BasicNumericTickProviderSpec(zeroBound: false)),
            domainAxis: charts.DateTimeAxisSpec(
              tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                day: charts.TimeFormatterSpec(
                  format: 'EEEE',
                  transitionFormat: 'EEEE',
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildCardChartGram(
    {@required String title,
    @required int percent,
    @required int status,
    @required String statusCount,
    @required String date,
    @required chartData}) {
  var statusData;
  if (status == 1) {
    statusData = Row(children: <Widget>[
      Icon(
        Icons.trending_up,
        size: 12.0,
      ),
      Text(
        " " + statusCount + "%",
        style: overline.copyWith(color: Colors.green),
      )
    ]);
  } else {
    statusData = Row(children: <Widget>[
      Icon(
        Icons.trending_down,
        color: Colors.red,
        size: 12.0,
      ),
      Text(
        " " + statusCount + "%",
        style: overline.copyWith(color: Colors.red),
      )
    ]);
  }
  return Card(
    elevation: 4,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockVertical * 2,
                      top: SizeConfig.blockHorizotal * 3),
                  child: Text(
                    title,
                    style: subtitle2,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(left: SizeConfig.blockVertical * 2),
                      child: Text(
                        percent.toString() + " gram",
                        style: body2,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: SizeConfig.blockVertical * 1),
                      child: statusData,
                    ),
                  ],
                )
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 20.0, right: 10.0),
                alignment: Alignment.centerRight,
                child: CustomElevation(
                    height: 30.0,
                    child: RaisedButton(
                      highlightColor: colorPrimary,
                      //Replace with actual colors
                      color: colorPrimary,
                      onPressed: () => {},
                      child: Text(
                        "Filter",
                        style: overline.copyWith(color: Colors.white),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ))),
          ],
        ),
        Container(
          padding: EdgeInsets.only(
              left: SizeConfig.blockVertical * 2,
              top: SizeConfig.blockHorizotal * 1),
          child: Text(
            date,
            style: body2.copyWith(color: Colors.grey),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: SizeConfig.blockVertical * 3,
            bottom: SizeConfig.blockHorizotal * 3,
          ),
          width: double.infinity,
          height: 200,
          child: AreaAndLineChart(
            chartData,
            animate: true,
          ),
        ),
      ],
    ),
  );
}

Widget CardKolamDetail(BuildContext context, String title, String sub,
    String status, String stock, String checkout,String idKolam,String idJenis,String feedId) {
  var text;
  var color;
  ScreenUtil.instance = ScreenUtil()..init(context);
  if (status == "0") {
    text = "Belum Teraktivasi";
    color = Colors.grey;
  } else if (status == "1") {
    text = "Kosong";
    color = Colors.redAccent;
  } else if (status == "2") {
    text = "Sedang Budidaya";
    color = blueAqua;
  } else if (status == "3") {
    text = "Siap Panen";
    color = Colors.green;
  } else if (status == "-1") {
    text = "Belum Aktivasi Akun";
    color = Colors.redAccent;
  } else {
    text = status;
    color = Colors.redAccent;
  }

  final Widget svgIcon = Container(
    height: ScreenUtil().setHeight(300),
    child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(50)),
        ),
        child: Container(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(40)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: color,
                          size: 15.0,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 5.0),
                            child: title != "null"?Text(
                              text,
                              style: caption.copyWith(color: color,fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
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
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 5.0, left: 20),
                        child: title != "null"?Text(
                          "Kolam "+title,
                          style:
                              subtitle1.copyWith(fontWeight: FontWeight.bold,fontSize: ScreenUtil(allowFontScaling: false).setSp(50)),
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
                        margin: EdgeInsets.only(top: 2.0, left: 20),
                        child:  title != "null"?Text(
                          sub,
                          style: overline.copyWith(
                              fontWeight: FontWeight.bold,
                              color: greyTextColor,fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
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
                  ],
                ),
                Container(
                    alignment: Alignment.centerRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Stock Pakan :     ',
                                  style: overline.copyWith(
                                      color: greyTextColor,
                                      fontSize: ScreenUtil(allowFontScaling: false).setSp(35),
                                      fontWeight: FontWeight.bold)),
                            stock != "null"?TextSpan(
                                  text: stock,
                                  style: subtitle1.copyWith(
                                      fontWeight: FontWeight.bold,fontSize: ScreenUtil(allowFontScaling: false).setSp(40))):Shimmer.fromColors(
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
                                  )),
                            ],
                          ),
                        ),
                        Wrap(
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                alignment: Alignment.centerRight,
                                child: CustomElevation(
                                    height: ScreenUtil().setHeight(75),
                                    child: RaisedButton(
                                      highlightColor: colorPrimary,
                                      //Replace with actual colors
                                      color: colorPrimary,
                                      onPressed: () => {

                                        if(checkout == "Checkout"){
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  // duration: Duration(microseconds: 1000),
                                                  child:CheckoutFix(
                                                    idKolam: idKolam,
                                                    idIkan:idJenis,
                                                    feedId: feedId,)))
                                        }else{
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertStok(context, CheckoutReorder(
                                                    idKolam: idKolam,
                                                    idIkan:idJenis,
                                                    feedId: feedId,
                                                  ),PenentuanPakanView(
                                                      idKolam: idKolam,idIkan:idJenis,from:"laporan"),
                                                  ))

                                        }



                                    },
                                      child: Text(
                                        checkout == "null"?"....":checkout,
                                        style: overline.copyWith(
                                            color: Colors.white,fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                                      ),
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0),
                                      ),
                                    )))
                          ],
                        ),
                      ],
                    )),
              ],
            ))),
  );
  return svgIcon;
}

Widget CollapseDetailText(
    BuildContext context, String title, String Value, Color clr) {
  final Widget svgIcon = Container(
      child: RichText(
    text: TextSpan(
      style: TextStyle(color: Colors.black),
      children: <TextSpan>[
        TextSpan(
            text: title,
            style: body2.copyWith(color: textPrimary, fontSize: ScreenUtil(allowFontScaling: false).setSp(38))),
        TextSpan(
            text: Value,
            style: body2.copyWith(
                fontWeight: FontWeight.bold, color: clr, fontSize: ScreenUtil(allowFontScaling: false).setSp(38))),
      ],
    ),
  ));
  return svgIcon;
}

Widget DetailCard(BuildContext context, String title, String value, Color clr) {
  var dataValue;
  ScreenUtil.instance = ScreenUtil()..init(context);
  if (value.length <= 1 || value == "null" || value == "null gram ( null )") {
    dataValue = Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.white,
        child: Container(
          height: 20.0,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius:
              BorderRadius.all(
                  Radius.circular(
                      16.0))),
        ));
  } else {
    dataValue = Text(value,
        style: body2.copyWith(
            fontWeight: FontWeight.bold, color: clr, fontSize: ScreenUtil(allowFontScaling: false).setSp(45)));
  }
  final Widget svgIcon = Container(
      height: ScreenUtil().setHeight(200),
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.2),
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(50))),
        child: Container(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(40)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: overline.copyWith(
                      fontWeight: FontWeight.bold, color: greyTextColor,fontSize: ScreenUtil(allowFontScaling: false).setSp(35))),
              SizedBox(
                height: 5,
              ),
              dataValue,
            ],
          ),
        ),
      ));
  return svgIcon;
}
