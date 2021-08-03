import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:lelenesia_pembudidaya/src/Models/ListOrdersFeedModels.dart';
import 'package:lelenesia_pembudidaya/src/bloc/RiwayatBloc.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:shimmer/shimmer.dart';

class RiwayatPakan extends StatefulWidget {
  RiwayatPakan({Key key}) : super(key: key);

  @override
  _RiwayatPakanState createState() => _RiwayatPakanState();
}

class _RiwayatPakanState extends State<RiwayatPakan> {
  TabController _controller;
  var itemsBelumCheckout = List<ListOrdersFeedModels>();
  var itemsProsesCheckout = List<ListOrdersFeedModels>();
  var itemsSudahCheckout = List<ListOrdersFeedModels>();
  var itemsPerjalananCheckout = List<ListOrdersFeedModels>();
  var itemsSelesaiCheckout = List<ListOrdersFeedModels>();
  var loading = true;
  void fetchData() async {
     bloc.fetchRiwayatList().then((value) {
      List<ListOrdersFeedModels> dataKolam = new List();
      setState(() {
        dataKolam = value;
        itemsBelumCheckout.addAll(dataKolam);
        itemsProsesCheckout.addAll(dataKolam);
        itemsSudahCheckout.addAll(dataKolam);
        itemsPerjalananCheckout.addAll(dataKolam);
        itemsSelesaiCheckout.addAll(dataKolam);
        loading = false;

      });

    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    debugPrint("${loading}");

  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: backgroundGreyColor,
          appBar: AppBar(
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            title: Text(
              "Status Pemesanan",
              style: h3,
            ),
            elevation: 1,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            bottom: PreferredSize(
                child: TabBar(
                    indicatorColor: colorPrimary,
                    isScrollable: true,
                    unselectedLabelColor: Colors.white.withOpacity(0.3),
                    tabs: [
                      Tab(
                        child: Container(
                          child: Text(
                            'Belum Checkout',
                            style: caption.copyWith(fontSize: ScreenUtil(allowFontScaling: false)
                                .setSp(35)),
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Sudah Checkout',
                          style: caption.copyWith(fontSize: ScreenUtil(allowFontScaling: false)
                              .setSp(35)),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Proses',
                          style: caption.copyWith(fontSize: ScreenUtil(allowFontScaling: false)
                              .setSp(35)),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Perjalanan',
                          style: caption.copyWith(fontSize: ScreenUtil(allowFontScaling: false)
                              .setSp(35)),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Selesai',
                          style: caption.copyWith(fontSize: ScreenUtil(allowFontScaling: false)
                              .setSp(35)),
                        ),
                      ),
                      // Tab(
                      //   child: Text(
                      //     'Di Tolak',
                      //     style: caption,
                      //   ),
                      // )
                    ]),
                preferredSize: Size.fromHeight(30.0)),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(Icons.add_alert),
              ),
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              ListView.builder(
                physics: new BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: itemsBelumCheckout.length,
                itemBuilder: (BuildContext context, int index) {
                  return itemsBelumCheckout[index].status == "0"?InkWell(
                      onTap: () {},
                      child: Container(
                        child: buildList(context,itemsBelumCheckout[index].pondName.toString(),itemsBelumCheckout[index].feedName.toString(),itemsBelumCheckout[index].feedPrice.toString()
                            ,itemsBelumCheckout[index].orderAmount.toString(),itemsBelumCheckout[index].totalPayment.toString(),itemsBelumCheckout[index].feedPhoto.toString(),itemsBelumCheckout[index].feedType.toString(),itemsBelumCheckout[index].orderedAt),
                      )):Container(child:Text(""));

                },
              ),
              ListView.builder(
                physics: new BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: itemsSudahCheckout.length,
                itemBuilder: (BuildContext context, int index) {
                  return itemsSudahCheckout[index].status == "1"?InkWell(
                      onTap: () {},
                      child: Container(
                        child: buildList(context,itemsSudahCheckout[index].pondName.toString(),itemsSudahCheckout[index].feedName.toString(),itemsSudahCheckout[index].feedPrice.toString()
                            ,itemsSudahCheckout[index].orderAmount.toString(),itemsSudahCheckout[index].totalPayment.toString(),itemsSudahCheckout[index].feedPhoto.toString(),itemsSudahCheckout[index].feedType.toString(),itemsSudahCheckout[index].orderedAt),
                      )):SizedBox(height: 1,);

                },
              ),
              ListView.builder(
                physics: new BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: itemsProsesCheckout.length,
                itemBuilder: (BuildContext context, int index) {
                  return itemsProsesCheckout[index].status == "2"?InkWell(
                      onTap: () {},
                      child: Container(
                        child: buildList(context,itemsProsesCheckout[index].pondName.toString(),itemsProsesCheckout[index].feedName.toString(),itemsProsesCheckout[index].feedPrice.toString()
                            ,itemsProsesCheckout[index].orderAmount.toString(),itemsProsesCheckout[index].totalPayment.toString(),itemsProsesCheckout[index].feedPhoto.toString(),itemsProsesCheckout[index].feedType.toString(),itemsProsesCheckout[index].orderedAt),
                      )):SizedBox(height: 1,);
                },
              ),
              ListView.builder(
                physics: new BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: itemsPerjalananCheckout.length,
                itemBuilder: (BuildContext context, int index) {
                  return itemsPerjalananCheckout[index].status == "3"?InkWell(
                      onTap: () {},
                      child: Container(
                        child: buildList(context,itemsPerjalananCheckout[index].pondName.toString(),itemsPerjalananCheckout[index].feedName.toString(),itemsPerjalananCheckout[index].feedPrice.toString()
                            ,itemsPerjalananCheckout[index].orderAmount.toString(),itemsPerjalananCheckout[index].totalPayment.toString(),itemsPerjalananCheckout[index].feedPhoto.toString(),itemsPerjalananCheckout[index].feedType.toString(),itemsPerjalananCheckout[index].orderedAt),
                      )):SizedBox(height: 1,);

                },
              ),
              ListView.builder(
                physics: new BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: itemsSelesaiCheckout.length,
                itemBuilder: (BuildContext context, int index) {
                  return itemsSelesaiCheckout[index].status == "4"?InkWell(
                      onTap: () {},
                      child: Container(
                        child: buildList(context,itemsSelesaiCheckout[index].pondName.toString(),itemsSelesaiCheckout[index].feedName.toString(),itemsSelesaiCheckout[index].feedPrice.toString()
                            ,itemsSelesaiCheckout[index].orderAmount.toString(),itemsSelesaiCheckout[index].totalPayment.toString(),itemsSelesaiCheckout[index].feedPhoto.toString(),itemsSelesaiCheckout[index].feedType.toString(),itemsSelesaiCheckout[index].orderedAt),
                      )):SizedBox(height: 1,);

                },
              ),
            ],
          )),
    );
  }

  Widget buildList(BuildContext ctx, String pond_name, String feed_name,
      String feed_price, String order_amount, String total_payment,String image_link,String jenis_pakan,DateTime dateTime) {
    ScreenUtil.instance = ScreenUtil()..init(context);

    // var val      = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(dateTime);
    var val      = DateFormat("dd MMMM yyyy hh:mm:ss").format(dateTime);
    final Widget svgIcon = Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.only(left: 25.0, right: 25.0),
      margin: EdgeInsets.only(top: SizeConfig.blockVertical * 2),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: SizeConfig.blockVertical * 2),
            child: Text(
              "Pesanan Kolam  ${pond_name}",
              style: caption.copyWith(fontSize: ScreenUtil(allowFontScaling: false)
                  .setSp(40)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Text(
              "Dipesan pada",
              style: overline.copyWith(color: greyIconColor, fontSize: ScreenUtil(allowFontScaling: false)
                  .setSp(35)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Text(
              "${val}",
              style: overline.copyWith(color: greyIconColor, fontSize: ScreenUtil(allowFontScaling: false)
                  .setSp(35)),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top:ScreenUtil().setHeight(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 70.0,
                  child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(8.0),
                      child: Image.network(
                        image_link + "",
                        fit: BoxFit.cover,
                        height:
                        SizeConfig.blockHorizotal * 17,
                        errorBuilder: (BuildContext context,
                            Object exception,
                            StackTrace stackTrace) {
                          return Image.network(
                            image_link + "",
                            height:
                            SizeConfig.blockHorizotal *
                                17,
                            fit: BoxFit.cover,
                            frameBuilder: (context,
                                child,
                                frame,
                                wasSynchronouslyLoaded) {
                              if (wasSynchronouslyLoaded) {
                                return child;
                              } else {
                                return AnimatedSwitcher(
                                  duration: const Duration(
                                      milliseconds: 500),
                                  child: frame != null
                                      ? child
                                      : Shimmer.fromColors(
                                    baseColor: Colors
                                        .grey[300],
                                    highlightColor:
                                    Colors
                                        .grey[200],
                                    period: Duration(
                                        milliseconds:
                                        1000),
                                    child: Container(
                                      width:
                                      ScreenUtil().setWidth(200),
                                      height: ScreenUtil().setHeight(200),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              10),
                                          color: Colors
                                              .white),
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: Text(
                          "${feed_name}",
                          style: caption.copyWith(fontSize: ScreenUtil(allowFontScaling: false)
                              .setSp(40),fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: Text(
                          "${feed_price}",
                          style: caption.copyWith(fontSize: ScreenUtil(allowFontScaling: false)
                              .setSp(35)),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(text: 'Jenis Produk ', style: caption.copyWith(fontSize: ScreenUtil(allowFontScaling: false).setSp(30))),
                              TextSpan(text: ' : ${jenis_pakan}', style: caption.copyWith(fontSize: ScreenUtil(allowFontScaling: false).setSp(30),fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      )

                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(top: 5.0),
            child: Text(
              "${order_amount}, Total",
              style: caption.copyWith(color: Colors.black, fontSize: ScreenUtil(allowFontScaling: false)
                  .setSp(40)),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(top: 5.0, bottom: 20.0),
            child: Text(
              "${total_payment}",
              style: body2.copyWith(color: colorPrimary,fontSize: ScreenUtil(allowFontScaling: false)
                  .setSp(40)),
            ),
          ),
        ],
      ),
    );
    return svgIcon;
  }
}
