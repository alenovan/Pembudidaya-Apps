import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lelenesia_pembudidaya/src/Models/ListKolamModels.dart';
import 'package:lelenesia_pembudidaya/src/Models/ListPakanModels.dart';
import 'package:lelenesia_pembudidaya/src/bloc/PakanBloc.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/CheckoutView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/KolamWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/pakan/DetailPenentuanPakan.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dotted_border/dotted_border.dart';
class PenentuanPakanView extends StatefulWidget {
  final String idKolam;
  const PenentuanPakanView({Key key, this.idKolam}) : super(key: key);

  @override
  _PenentuanPakanViewState createState() => _PenentuanPakanViewState();
}

class _PenentuanPakanViewState extends State<PenentuanPakanView> {
  bool _clickForgot = true;
  List<ListPakanModels> dataPakan = new List();
  var items = List<ListPakanModels>();
  TextEditingController _searchBoxController = TextEditingController();
  void fetchData() {
    bloc.fetchAllPakan().then((value) {
      setState(() {
        dataPakan = value;
        items.addAll(dataPakan);
        // dataPakan.addAll(value);

      });
    });

  }
  onItemChanged(String query) {
    List<ListPakanModels> dummySearchList = List<ListPakanModels>();
    dummySearchList.addAll(dataPakan);
    if(query.isNotEmpty) {
      List<ListPakanModels> dummyListData = List<ListPakanModels>();

      dummySearchList.forEach((item) {

        if(item.name.toLowerCase().contains(query.toLowerCase())) {
          print(item.name);
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(dataPakan);
      });
    }
  }
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  dispose() {
    super.dispose();
  }


  void _toggleButtonForgot() {
    setState(() {
      _clickForgot = !_clickForgot;
    });
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            // duration: Duration(microseconds: 1000),
            child: CheckoutView()));
  }


  GestureDetector gs = GestureDetector(
      onTap: () {
        // _togglevisibility();
      },
      child: Icon(
        Icons.search ,
        color: greyIconColor,
      ));

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
    ),
    child:Scaffold(
        backgroundColor: Colors.grey[100],
    resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: DashboardView()))
            },
          ),
          actions: <Widget>[],
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          title: Text(
            "Penentuan Pakan",
            style: h3,
          ),
        ),
    body: Container(
            child:Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: SizeConfig.blockVertical * 4,
                      left: SizeConfig.blockVertical * 2,
                      right: SizeConfig.blockVertical * 2),
                  child: Column(
                    children: [
                      Container(
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          onChanged: onItemChanged,
                          controller: _searchBoxController,
                          decoration: EditText(
                              context, "Cari Pabrik Pakan", 20.0, 0, 0, 0,gs),
                          keyboardType: TextInputType.text,
                          style: body2,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child:Container(
                    margin: EdgeInsets.only(
                        top: SizeConfig.blockVertical * 2,
                        left: SizeConfig.blockVertical * 2,
                        right: SizeConfig.blockVertical * 2),
                  child: Container(
                    child: FutureBuilder(
                      future: bloc.fetchAllPakan(),
                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          return buildList(snapshot);
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    )
                  )),
                ),
              ],
            )

        )));
  }


  Widget buildList(AsyncSnapshot<dynamic> snapshot) {
    return ListView.builder(
      physics: new BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onTap: (){

              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: DetailPenentuanPakan(
                        idKolam: widget.idKolam,
                        id_pakan: items[index].id,
                        name: items[index].name,
                        stok: items[index].stock,
                        size: items[index].size,
                        type: items[index].type,
                        price: items[index].price,
                        desc: items[index].description,
                        image_url: items[index].photo,
                      )));
            },
            child:Container(
              child: CardPenentuanPakan(context,items[index].name,"5.0","0.5 Km",items[index].price,items[index].photo),

            )
        );
      },
    );
  }




}
