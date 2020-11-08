import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';

class RiwayatPakan extends StatefulWidget {
  RiwayatPakan({Key key}) : super(key: key);

  @override
  _RiwayatPakanState createState() => _RiwayatPakanState();
}

class _RiwayatPakanState extends State<RiwayatPakan> {
  TabController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
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
                        child: Text('Belum Checkout',style: caption,),
                      ),
                      Tab(
                        child: Text('Sudah Checkout',style: caption,),
                      ),
                      Tab(
                        child: Text('Diterima Pabrik',style: caption,),
                      ),
                      Tab(
                        child: Text('Dikirim',style: caption,),
                      ),
                      Tab(
                        child: Text('Selesai',style: caption,),
                      ),
                      Tab(
                        child: Text('Di Tolak',style: caption,),
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
              Container(
                child: Center(
                  child: Text('Tab 1'),
                ),
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
}
