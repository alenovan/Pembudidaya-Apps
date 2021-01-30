import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/DetailKolam.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/riwayat/RiwayatKolam.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/home/LaporanHomeWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lelenesia_pembudidaya/src/bloc/KolamBloc.dart' as kolam;
import 'package:lelenesia_pembudidaya/src/bloc/CheckoutBloc.dart' as checkout;
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;
import 'package:lelenesia_pembudidaya/src/bloc/LoginBloc.dart' as login;
class HomeLaporan extends StatefulWidget {
  final String idKolam;

  HomeLaporan({Key key, @required this.idKolam}) : super(key: key);

  @override
  _HomeLaporanState createState() => _HomeLaporanState();
}

class _HomeLaporanState extends State<HomeLaporan> {
  ScrollController _controller_scroll;
  bool silverCollapsed = false;
  var status_checkout = false;
  String myTitle = "";
  Color silverColor = Colors.transparent;
  Color tmblColor = Colors.black;
  int _status_kolam = 0;
  String _sow_date,
      _est_panen,
      _fish_type,
      _seed_mount_current,
      _weight_fish_current,
      _target_price,
      _budget,
      _budget_seed,
      _omset,
      _laba,
      _est_weight_fish,
      _nama_kolam,
      _stock_pakan = "";
  String _sr,
      _fcr,
      _target_fish_count,
      _seed_price,
      _seed_amount,
      _feed_requirement_estimation,
      _est_feed_budget,
      text_status_checkout,
      id_order = "";
  final formatter = new NumberFormat('#,##0', 'ID');

  @override
  void initState() {
    update();
    marketLogin();
    super.initState();
    initializeDateFormatting(); //very important
    _controller_scroll = ScrollController();
    _controller_scroll.addListener(() {
      if (_controller_scroll.offset > 20 &&
          !_controller_scroll.position.outOfRange) {
        if (!silverCollapsed) {
          myTitle = "Detail Kolam";
          silverCollapsed = true;

          setState(() {
            silverColor = colorPrimary;
            tmblColor = Colors.white;
          });
        }
      }
      if (_controller_scroll.offset <= 20 &&
          !_controller_scroll.position.outOfRange) {
        if (silverCollapsed) {
          myTitle = "";
          silverCollapsed = false;
          silverColor = Colors.transparent;
          setState(() {
            silverColor = Colors.transparent;
            tmblColor = Colors.black;
          });
        }
      }
    });

  }

  void marketLogin() async{

    var status = await login.bloc.login_market();
    if(status){
      dynamic token_market = await FlutterSession().get("token_market");
      print("toko masuk ${token_market}");
    }
  }

  void detailOrder(String id_orders) async {
    try {
      var detail = await checkout.bloc.getCheckOrderId(id_orders.toString());
      await WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          status_checkout = detail;
          print(status_checkout);
          if (status_checkout) {
            text_status_checkout = "Checkout";
          } else {
            text_status_checkout = "Beli";
          }
        });
      });
    } catch (error) {
      text_status_checkout = "Beli";
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void update() async {
    var detail = await kolam.bloc.getKolamDetail(widget.idKolam);
    var data = detail['data'];
    setState(() {
      try {
        id_order = data['harvest']['last_order_id'].toString();
        detailOrder(id_order);
      } catch (error) {
        text_status_checkout = "Beli";
      }
      _sr = "${data['harvest']['current_sr']} %";
      _seed_amount = data['harvest']['seed_amount'].toString() + " Ekor";
      _feed_requirement_estimation =data['harvest']['feed_requirement_estimation'].toStringAsFixed(0) +" Kg";
      var fish_type = data['harvest']['fish_type_id'].toString();
      if(fish_type == "1"){
        _fish_type = "Ikan Lele";
      }else if(fish_type == "2"){
        _fish_type = "Ikan Nila";
      }else{
        _fish_type = "Ikan Emas";
      }
      _fcr = data['harvest']['feed_conversion_ratio'].toString();
      _target_fish_count = data['harvest']['target_fish_count'].toString();
      _seed_price = "Rp." + formatter.format(data['harvest']['seed_price']);
      _stock_pakan ="${data['harvest']['current_stocked_feed']} Kg";
      _sow_date = DateFormat('dd/MM/yyyy')
          .format(DateTime.parse(data['harvest']['sow_date']));
      _est_panen = data['harvest']['harvest_date_estimation'].toString();
      _nama_kolam = data['name'].toString();
      _status_kolam = data['status'];
      _seed_mount_current =
          data['harvest']['current_amount'].toString() + " Ekor";
      // _weight_fish_current = (data['harvest']['current_weight'] * data['harvest']['current_amount']).toString();
      _weight_fish_current = (data['harvest']['current_weight']).toString();
      _target_price =
          "Rp." + formatter.format(data['harvest']['target_price']).toString();
      _budget_seed = "Rp." + formatter.format(data['harvest']['seed_price'] * data['harvest']['seed_amount']).toString();
      _budget = "Rp." + formatter.format(data['harvest']['budget']);
      _omset = "Rp." + formatter.format(data['harvest']['revenue']).toString();
      _laba = "Rp." +
          formatter.format(int.parse(
              data['harvest']['profit_estimation'].toStringAsFixed(0)));
      // _est_weight_fish = (int.parse(data['harvest']['harvest_weight_estimation'].toStringAsFixed(0))/1000).toStringAsFixed(0).toString();
      _est_weight_fish = data['harvest']['harvest_weight_estimation'].toStringAsFixed(0)+" Kg";
      var feed = (data['harvest']['feed_requirement_estimation']);
      _est_feed_budget = "Rp." +
          formatter.format(int.parse(
              (feed * data['harvest']['feed_price']).toStringAsFixed(0)));
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Image.asset(
                "assets/png/header_laporan.png",
                fit: BoxFit.cover,
                width: double.infinity,
                height: ScreenUtil().setHeight(500),
              ),
            ),
            CustomScrollView(
              controller: _controller_scroll,
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: silverColor,
                  title: Text(myTitle),
                  leading: GestureDetector(
                    onTap: ()=>{
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: DetailKolam(
                                idKolam: widget.idKolam,
                              )))
                    },
                    child: Icon(Icons.arrow_back,
                        color: tmblColor,
                        size: ScreenUtil(allowFontScaling: false).setSp(80)),
                  ),
                  floating: true,
                  snap: true,
                  actions: <Widget>[
                    PopupMenuButton<int>(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: [
                              Icon(Icons.history, color: tmblColor),
                              Text(
                                "  Riwayat Kolam",
                                style: body2,
                              )
                            ],
                          ),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == 1) {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: RiwayatKolam(
                                    idKolam: widget.idKolam,
                                  )));
                        }
                      },
                      icon: Icon(
                        Icons.more_vert,
                        color: tmblColor,
                        size: ScreenUtil(allowFontScaling: false).setSp(80),
                      ),
                    )
                  ],
                  // pinned: true,
                  flexibleSpace: FlexibleSpaceBar(),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Stack(
                      children: [
                        Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(50),
                                right: ScreenUtil().setWidth(20),
                                top: ScreenUtil().setHeight(10)),
                            child: Text("")),
                        Container(
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(20),
                              left: ScreenUtil().setWidth(50),
                              right: ScreenUtil().setWidth(50)),
                          child: CardKolamDetail(
                              context,
                              "${_nama_kolam}",
                              "${_fish_type}",
                              "${_status_kolam}",
                              "${_stock_pakan}",
                              "${text_status_checkout}"),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(20),
                          left: ScreenUtil().setWidth(50),
                          right: ScreenUtil().setWidth(50)),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setWidth(50)),
                        ),
                        child: ExpandablePanel(
                          header: Builder(
                            builder: (context) {
                              var controller = ExpandableController.of(context);
                              return FlatButton(
                                height: ScreenUtil().setHeight(200),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Icon(
                                              controller.expanded
                                                  ? Boxicons.bxs_chevron_down_circle
                                                  : Boxicons.bxs_chevron_right_circle,
                                              color: purpleTextColor,
                                              size: ScreenUtil(
                                                      allowFontScaling: false)
                                                  .setSp(60),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(2),
                                                left:
                                                    ScreenUtil().setWidth(50)),
                                            child: Text(
                                              "Informasi Kolam",
                                              style: subtitle1.copyWith(
                                                  color: Colors.black,
                                                  fontSize: ScreenUtil(
                                                          allowFontScaling:
                                                          false)
                                                      .setSp(50),
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                                onPressed: () {
                                  controller.toggle();
                                },
                              );
                            },
                          ),
                          expanded: Container(
                            transform:
                                Matrix4.translationValues(0.0, -2.0, 0.0),
                            padding: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 7,
                                right: SizeConfig.blockVertical * 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CollapseDetailText(
                                    context,
                                    "Jumlah Ikan awal : ",
                                    "${_seed_amount}",
                                    textPrimary),
                                SizedBox(
                                  height: 10,
                                ),
                                CollapseDetailText(
                                    context,
                                    "Asumsi SR :  ",
                                    "${_sr}",
                                    textPrimary),
                                SizedBox(
                                  height: 10,
                                ),
                                CollapseDetailText(
                                    context,
                                    "Asumsi FCR  : ",
                                    "${_fcr}",
                                    textPrimary),
                                SizedBox(
                                  height: 10,
                                ),
                                CollapseDetailText(
                                    context,
                                    "Target Jumlah panen ekor per kg : ",
                                    "${_target_fish_count} ekor",
                                    textPrimary),
                                SizedBox(
                                  height: 10,
                                ),
                                CollapseDetailText(context, "Harga Bibit : ",
                                    "${_seed_price}", textPrimary),
                                SizedBox(
                                  height: 10,
                                ),
                                CollapseDetailText(context, "Modal Benih : ",
                                    "${_budget_seed}", textPrimary),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          tapHeaderToExpand: true,
                          hasIcon: false,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(20),
                          left: ScreenUtil().setWidth(50),
                          right: ScreenUtil().setWidth(50)),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setWidth(50)),
                        ),
                        child: ExpandablePanel(
                          header: Builder(
                            builder: (context) {
                              var controller = ExpandableController.of(context);
                              return FlatButton(
                                height: SizeConfig.blockVertical * 10,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Icon(
                                              controller.expanded
                                                  ? Boxicons.bxs_chevron_down_circle
                                                  : Boxicons.bxs_chevron_right_circle,
                                              color: purpleTextColor,
                                              size: ScreenUtil(
                                                  allowFontScaling: false)
                                                  .setSp(60),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(2),
                                                left:
                                                    ScreenUtil().setWidth(50)),
                                            child: Text(
                                              "Informasi Pakan",
                                              style: subtitle1.copyWith(
                                                  color: Colors.black,
                                                  fontSize: ScreenUtil(
                                                          allowFontScaling:
                                                          false)
                                                      .setSp(50),
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                                onPressed: () {
                                  controller.toggle();
                                },
                              );
                            },
                          ),
                          expanded: Container(
                            transform:
                                Matrix4.translationValues(0.0, -2.0, 0.0),
                            padding: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 7,
                                right: SizeConfig.blockVertical * 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CollapseDetailText(
                                    context,
                                    "Prediksi Pengeluaran Pakan : ",
                                    "${_feed_requirement_estimation}",
                                    textPrimary),
                                SizedBox(
                                  height: 10,
                                ),
                                CollapseDetailText(
                                    context,
                                    "Prediksi Modal Pakan :  ",
                                    "${_est_feed_budget}",
                                    colorPrimary),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          tapHeaderToExpand: true,
                          hasIcon: false,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(20),
                          left: ScreenUtil().setWidth(50),
                          right: ScreenUtil().setWidth(50)),
                      child: Text(
                        "Prediksi Panen",
                        style: body2.copyWith(
                            color: textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil(allowFontScaling: false).setSp(55)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(20),
                          left: ScreenUtil().setWidth(50),
                          right: ScreenUtil().setWidth(50)),
                      child: Row(
                        children: [
                          Expanded(
                            child: DetailCard(
                                context, "Tebar Benih", "${_sow_date}", textPrimary),
                          ),
                          Expanded(
                            child: DetailCard(context, "Panen", "${_est_panen}",
                                colorPrimary),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(20),
                          left: ScreenUtil().setWidth(50),
                          right: ScreenUtil().setWidth(50)),
                      child: DetailCard(context, "Jumlah ikan Saat ini",
                          "${_seed_mount_current}", textPrimary),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(20),
                          left: ScreenUtil().setWidth(50),
                          right: ScreenUtil().setWidth(50)),
                      child: DetailCard(
                          context,
                          "Berat Ikan Saat ini (Target berat per Ekor)",
                          "${_weight_fish_current} gram ( ${_est_weight_fish} )",
                          textPrimary),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(20),
                          left: ScreenUtil().setWidth(50),
                          right: ScreenUtil().setWidth(50)),
                      child: DetailCard(
                          context,
                          "Target Harga Jual Per Kilogram",
                          "${_target_price}",
                          textPrimary),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(20),
                          left: ScreenUtil().setWidth(50),
                          right: ScreenUtil().setWidth(40)),
                      child: DetailCard(context, "Informasi Modal Keseluruhan (Termasuk 5% Ops cost)",
                          "${_budget}", textPrimary),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(20),
                          left: ScreenUtil().setWidth(50),
                          right: ScreenUtil().setWidth(40)),
                      child: DetailCard(context, "Prediksi Informasi Omset",
                          "${_omset}", colorPrimary),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(20),
                          left: ScreenUtil().setWidth(50),
                          right: ScreenUtil().setWidth(40)),
                      child: DetailCard(
                          context,
                          "Prediksi Informasi Keuntungan",
                          "${_laba}",
                          colorPrimary),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ]),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

//
}
