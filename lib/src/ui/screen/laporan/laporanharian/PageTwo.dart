import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:page_transition/page_transition.dart';

class PageTwo extends StatefulWidget {
  final String idKolam;
  final int tgl;
  final int bulan;
  final int tahun;
  final DateTime isoData;
  PageTwo({Key key, this.idKolam, this.tgl, this.bulan, this.tahun, this.isoData}) : super(key: key);

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  bool _showDetail = true;
  void _toggleSimpan() async {
    // Navigator.of(context).push(new MaterialPageRoute<Null>(
    //     builder: (BuildContext context) {
    //       return LoadingShow(context);
    //     },
    //     fullscreenDialog: true));
    // var status = await bloc.feedMonitor(widget.idKolam,feedController.text.toString());
    // if(status){
    //   Navigator.of(context).pop();
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              // duration: Duration(microseconds: 1000),
              child: LaporanMain(
                idKolam: widget.idKolam.toString(),
                tgl: widget.tgl,
                bulan: widget.bulan,
                tahun: widget.tahun,
                dataPageTwo : feedController.text.toString(),
                isoString: widget.isoData,
                page: 2,
                laporan_page: "tiga",
              )));
    // }else{
    //   Navigator.of(context).pop();
    //   BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali");
    // }
  }
  TextEditingController feedController = TextEditingController();
  @override
  void initState() {
    print(widget.isoData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.isoData);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child:Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backgroundGreyColor,
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => {
                Navigator.pop(context,true)
              },
            ),
            actions: <Widget>[],
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            title: Text(
              "Laporan",
              style: h3,
            ),
          ),
          body:  Column(
              children: [
              Expanded(child: Container(
                margin: EdgeInsets.only(
                    left: SizeConfig.blockVertical * 3,
                    right: SizeConfig.blockVertical * 3,
                    bottom: SizeConfig.blockVertical * 20),
                color: backgroundGreyColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                            padding: EdgeInsets.all(25.0),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "Berapa pakan yang kamu habiskan hari ini ? (Kilogram)",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: blackTextColor,
                                        fontFamily: 'poppins',
                                        letterSpacing: 0.25,
                                        fontSize: 16.0),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  child: TextFormField(
                                    controller: feedController,
                                    decoration: EditTextDecorationText(
                                        context, "", 20.0, 0, 0, 0),
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        color: blackTextColor,
                                        fontFamily: 'lato',
                                        letterSpacing: 0.4,
                                        fontSize: subTitleLogin),
                                  ),
                                ),
                                Container(
                                  height: 45.0,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockVertical * 3,
                                      right: SizeConfig.blockVertical * 3,
                                      top: SizeConfig.blockVertical * 3),
                                  child: CustomElevation(
                                      height: 30.0,
                                      child: RaisedButton(
                                        highlightColor:
                                            colorPrimary, //Replace with actual colors
                                        color: colorPrimary,
                                        onPressed: () => {
                                          if(feedController.text.trim() == ""){
                                          BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Pastikan data terisi semua")
                                          }else{
                                            _toggleSimpan()
                                          }
                                        },
                                        child: Text(
                                          "Selanjutnya",
                                          style: TextStyle(
                                              color: backgroundColor,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'poppins',
                                              letterSpacing: 1.25,
                                              fontSize: subTitleLogin),
                                        ),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0),
                                        ),
                                      )),
                                )
                              ],
                            )))
                  ],
                )))
              ],
          )),);
  }
}

