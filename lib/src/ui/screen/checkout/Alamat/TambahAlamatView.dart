import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/Models/KecamatanModel.dart';
import 'package:lelenesia_pembudidaya/src/Models/KotaModel.dart';
import 'package:lelenesia_pembudidaya/src/Models/ProvinsiModel.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/Alamat/ListAlamatPengiriman.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AcceptanceDialog.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/bloc/ProfilBloc.dart' as geolocation;
import 'package:lelenesia_pembudidaya/src/ui/widget/LoadingDialog.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;
import 'package:page_transition/page_transition.dart';

class TambahAlamatView extends StatefulWidget {
  final String idKolam;

  const TambahAlamatView({Key key, @required this.idKolam}) : super(key: key);

  @override
  _TambahAlamatViewState createState() => _TambahAlamatViewState();
}

class _TambahAlamatViewState extends State<TambahAlamatView> {
  var blox;
  var loop = 0;

  //provinsigetKecamatan
  List<ProvinsiModel> itemsProvinsi = [];
  //kota
  List<KotaModel> itemsKota = [];
  //Kecamatan
  List<KecamatanModel> itemsKecamatan = [];

  var selectedProvinsi;
  var selectedKota;
  var selectedKecamatan;
  @override
  void initState() {
    super.initState();
    getProvinsi();
    update();
  }

  bool _clickForgot = true;
  bool isButtonEnabled = false;
  TextEditingController namaLengkapController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  TextEditingController kotaController = TextEditingController();
  TextEditingController provinsiController = TextEditingController();
  TextEditingController kelurahanController = TextEditingController();
  TextEditingController kecamatanController = TextEditingController();

  void _toggleSimpan() async {
    LoadingDialog.show(context);
    var status = await geolocation.bloc.funAddAlamat(
        namaLengkapController.text.toString(),
        noHpController.text.toString(),
        alamatController.text.toString(),
        selectedProvinsi.toString(),
        selectedKota.toString(),
        selectedKecamatan.toString());
    if (status) {
      AppExt.popScreen(context);
      BottomSheetFeedback.show_success(context,
          title: "Selamat", description: "Alamat Berhasil Di Tambahkan");

      Timer(const Duration(seconds: 2), () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: ListAlamatPengiriman(
                  idKolam: widget.idKolam,
                )));
      });
    } else {
      AppExt.popScreen(context);
      BottomSheetFeedback.show(context,
          title: "Mohon Maaf", description: "Silahkan ulangi kembali");
    }
  }

  void checkInput() {
    if ((namaLengkapController.text.trim() != "") &&
        (alamatController.text.trim() != "")) {
      setState(() {
        isButtonEnabled = true;
      });
    } else {
      setState(() {
        isButtonEnabled = false;
      });
    }
  }

  void update() async {
    blox = await geolocation.bloc.getProfile();
    // namaLengkapController.text = blox['data']['name'];
    // alamatController.text = blox['data']['address'];
    checkInput();
  }

  void getProvinsi() {
    itemsProvinsi.clear();
    geolocation.bloc.getProvinsi().then((value) {
      List<ProvinsiModel> dataKolam = new List();
      setState(() {
        dataKolam = value;
        itemsProvinsi.addAll(dataKolam);
      });
    });
  }

  void getKota(String id_provinsi) {
    itemsKota.clear();
    geolocation.bloc.getKota(id_provinsi).then((value) {
      List<KotaModel> dataKolam = new List();
      setState(() {
        dataKolam = value;
        itemsKota.addAll(dataKolam);
        Navigator.pop(context);
      });
    });
  }

  void getKecamatan(String id_kota) {
    itemsKecamatan.clear();
    geolocation.bloc.getKecamatan(id_kota).then((value) {
      List<KecamatanModel> dataKolam = new List();
      setState(() {
        dataKolam = value;
        itemsKecamatan.addAll(dataKolam);
        Navigator.pop(context);
      });
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
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: ListAlamatPengiriman(
                          idKolam: widget.idKolam,
                        )))
              },
            ),
            actions: <Widget>[],
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            title: Text(
              "Alamat Pengiriman",
              style: h3,
            ),
          ),
          body: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                      physics: new BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 2,
                                right: SizeConfig.blockVertical * 5),
                            child: Text(
                              "Nama Lengkap",
                              style: TextStyle(
                                  color: appBarTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: 14.0),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 1,
                                right: SizeConfig.blockVertical * 5),
                            child: TextFormField(
                              controller: namaLengkapController,
                              decoration: EditTextDecorationText(
                                  context, "Nama Lengkap", 20.0, 0, 0, 0),
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                  color: blackTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: subTitleLogin),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 2,
                                right: SizeConfig.blockVertical * 5),
                            child: Text(
                              "Nomor Handphone",
                              style: TextStyle(
                                  color: appBarTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: 14.0),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 1,
                                right: SizeConfig.blockVertical * 5),
                            child: TextFormField(
                              onChanged: (val) {
                                checkInput();
                              },
                              controller: noHpController,
                              decoration: EditTextDecorationNumber(
                                  context, "Nomor Handphone"),
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  color: blackTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: ScreenUtil(allowFontScaling: false)
                                      .setSp(45)),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 2,
                                right: SizeConfig.blockVertical * 5),
                            child: Text(
                              "Provinsi",
                              style: TextStyle(
                                  color: appBarTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: 14.0),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 1,
                                right: SizeConfig.blockVertical * 5),
                            child: DropdownSearch<ProvinsiModel>(
                              searchBoxController: provinsiController,
                              items: itemsProvinsi,
                              mode: Mode.BOTTOM_SHEET,
                              isFilteredOnline: true,
                              showClearButton: true,
                              showSearchBox: true,
                              dropdownSearchDecoration: EditTextDecorationText(
                                  context, "", 20.0, 0, 0, 0),
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (ProvinsiModel u) =>
                                  u == null ? "Provinsi Wajib di Isi " : null,
                              onChanged: (ProvinsiModel data) {
                                checkInput();
                                showLoaderDialog(context);
                                setState(() {
                                  selectedProvinsi = data.id;
                                });
                                getKota(data.id.toString());
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 2,
                                right: SizeConfig.blockVertical * 5),
                            child: Text(
                              "Kota",
                              style: TextStyle(
                                  color: appBarTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: 14.0),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 1,
                                right: SizeConfig.blockVertical * 5),
                            child: DropdownSearch<KotaModel>(
                              searchBoxController: kotaController,
                              items: itemsKota,
                              mode: Mode.BOTTOM_SHEET,
                              isFilteredOnline: true,
                              showClearButton: true,
                              showSearchBox: true,
                              dropdownSearchDecoration: EditTextDecorationText(
                                  context, "", 20.0, 0, 0, 0),
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (KotaModel u) =>
                                  u == null ? "Kota Wajib di Isi " : null,
                              onChanged: (KotaModel data) {
                                checkInput();
                                showLoaderDialog(context);
                                setState(() {
                                  selectedKota = data.cityId;
                                });
                                getKecamatan(data.cityId.toString());
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 2,
                                right: SizeConfig.blockVertical * 5),
                            child: Text(
                              "Kecamatan",
                              style: TextStyle(
                                  color: appBarTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: 14.0),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 1,
                                right: SizeConfig.blockVertical * 5),
                            child: DropdownSearch<KecamatanModel>(
                              searchBoxController: kecamatanController,
                              items: itemsKecamatan,
                              mode: Mode.BOTTOM_SHEET,
                              isFilteredOnline: true,
                              showClearButton: true,
                              showSearchBox: true,
                              dropdownSearchDecoration: EditTextDecorationText(
                                  context, "", 20.0, 0, 0, 0),
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (KecamatanModel u) =>
                                  u == null ? "Kecamatan Wajib di Isi " : null,
                              onChanged: (KecamatanModel data) {
                                checkInput();
                                setState(() {
                                  selectedKecamatan = data.districtId;
                                });
                              },
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 2,
                                right: SizeConfig.blockVertical * 5),
                            child: Text(
                              "Alamat",
                              style: TextStyle(
                                  color: appBarTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: 14.0),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 1,
                                right: SizeConfig.blockVertical * 5),
                            child: TextFormField(
                              onChanged: (val) {
                                checkInput();
                              },
                              controller: alamatController,
                              decoration: EditTextDecorationText(
                                  context, "Alamat", 20.0, 0, 0, 0),
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                  color: blackTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: subTitleLogin),
                            ),
                          ),

                          Container(
                              margin: EdgeInsets.only(bottom: 20.0),
                              child: new Align(
                                  alignment: FractionalOffset.bottomCenter,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 45.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(
                                            left: SizeConfig.blockVertical * 5,
                                            right: SizeConfig.blockVertical * 5,
                                            top: 20.0),
                                        child: CustomElevation(
                                            height: 30.0,
                                            child: RaisedButton(
                                              highlightColor: colorPrimary,
                                              color: colorPrimary,
                                              onPressed: () =>
                                                  {_toggleSimpan()},
                                              child: Text(
                                                "Simpan",
                                                style: TextStyle(
                                                    color: backgroundColor,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'poppins',
                                                    letterSpacing: 1.25,
                                                    fontSize: subTitleLogin),
                                              ),
                                              shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        30.0),
                                              ),
                                            )),
                                      ),
                                      Container(
                                        height: 45.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(
                                            left: SizeConfig.blockVertical * 5,
                                            right: SizeConfig.blockVertical * 5,
                                            top: 15.0),
                                        child: CustomElevation(
                                            height: 30.0,
                                            child: RaisedButton(
                                              highlightColor: redTextColor,
                                              //Replace with actual colors
                                              color: redTextColor,
                                              onPressed: () => {
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        type: PageTransitionType
                                                            .fade,
                                                        child:
                                                            ListAlamatPengiriman(
                                                          idKolam:
                                                              widget.idKolam,
                                                        )))
                                              },
                                              // _toggleButtonForgot(),
                                              child: Text(
                                                "Batal",
                                                style: TextStyle(
                                                    color: backgroundColor,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'poppins',
                                                    letterSpacing: 1.25,
                                                    fontSize: subTitleLogin),
                                              ),
                                              shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        30.0),
                                              ),
                                            )),
                                      ),
                                    ],
                                  )))
                        ],
                      ))),
            ],
          ),
        ));
  }

  Future<bool> _onBackPressed() {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: ListAlamatPengiriman(
              idKolam: widget.idKolam,
            )));
  }
}
