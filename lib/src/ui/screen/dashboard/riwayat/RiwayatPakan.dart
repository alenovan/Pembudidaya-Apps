import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/Models/ListOrdersFeedModels.dart';
import 'package:lelenesia_pembudidaya/src/bloc/RiwayatBloc.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';

class RiwayatPakan extends StatefulWidget {
  RiwayatPakan({Key key}) : super(key: key);

  @override
  _RiwayatPakanState createState() => _RiwayatPakanState();
}

class _RiwayatPakanState extends State<RiwayatPakan> {
  TabController _controller;
  var items = List<ListOrdersFeedModels>();
  void fetchData()  {
     bloc.fetchRiwayatList().then((value) {
      List<ListOrdersFeedModels> dataKolam = new List();
      setState(() {
        dataKolam = value;
        items.addAll(dataKolam);
      });

    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();

  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: backgroundGreyColor,
          appBar: AppBar(
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            title: Text(
              "Status Pemesanan",
              style: h3,
            ),
            elevation: 0,
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
                        child: Text(
                          'Belum Checkout',
                          style: caption,
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Sudah Checkout',
                          style: caption,
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Diterima Pabrik',
                          style: caption,
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Dikirim',
                          style: caption,
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Selesai',
                          style: caption,
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Di Tolak',
                          style: caption,
                        ),
                      )
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
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: () {},
                      child: Container(
                        child: buildList(context,items[index].pondName.toString(),items[index].feedName.toString(),items[index].feedPrice.toString()
                        ,items[index].orderAmount.toString(),items[index].totalPayment.toString()),
                      ));
                },
              ),
              Container(
                child: Center(
                  child: Text('Tab 2'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 3'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 4'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 5'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 6'),
                ),
              ),
            ],
          )),
    );
  }

  Widget buildList(BuildContext ctx, String pond_name, String feed_name,
      String feed_price, String order_amount, String total_payment) {
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
              style: caption,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Text(
              "Dipesan pada",
              style: overline.copyWith(color: greyIconColor, fontSize: 12.0),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Text(
              "23 Okt 2020 09:03:18",
              style: overline.copyWith(color: greyIconColor, fontSize: 12.0),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Text(
              "${feed_name}",
              style: caption,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Text(
              "${feed_price}",
              style: caption,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(top: 5.0),
            child: Text(
              "${order_amount}, Total",
              style: caption.copyWith(color: Colors.black, fontSize: 12.0),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
            child: Text(
              "${total_payment}",
              style: body2.copyWith(color: colorPrimary),
            ),
          ),
        ],
      ),
    );
    return svgIcon;
  }
}
