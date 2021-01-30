
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/geolocation.dart';
import 'package:lelenesia_pembudidaya/src/Models/KecamatanModel.dart';
import 'package:lelenesia_pembudidaya/src/Models/KotaModel.dart';
import 'package:lelenesia_pembudidaya/src/Models/ProvinsiModel.dart';
import 'package:lelenesia_pembudidaya/src/bloc/ProfilBloc.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/ProfileWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/aktivasi/BiodataMapsScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/aktivasi/KtpScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AcceptanceDialog.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LoadingDialog.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;
import 'package:page_transition/page_transition.dart';
class BiodataScreen extends StatefulWidget {
  final String from;
  const BiodataScreen({Key key, this.from}) : super(key: key);

  @override
  _BiodataScreenState createState() => _BiodataScreenState();
}

class _BiodataScreenState extends State<BiodataScreen> {
  var blox;
  var loop = 0;
  double latitude;
  double longtitude;
  //provinsigetKecamatan
  List<ProvinsiModel> itemsProvinsi = [];
  //kota
  List<KotaModel> itemsKota = [];
  //Kecamatan
  List<KecamatanModel> itemsKecamatan= [];

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
  TextEditingController kotaController = TextEditingController();
  TextEditingController provinsiController = TextEditingController();
  TextEditingController kodePosController = TextEditingController();
  TextEditingController kelurahanController = TextEditingController();
  TextEditingController kecamatanController = TextEditingController();

  void _toggleSimpan() async {
    LoadingDialog.show(context);
    if (isButtonEnabled) {
      var status = await bloc.funUpdateProfile(
        namaLengkapController.text.toString(),
        alamatController.text.toString(),
          selectedProvinsi.toString(),
        selectedKota.toString(),
        selectedKecamatan.toString()
      );
      AppExt.popScreen(context);
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              // duration: Duration(microseconds: 1000),
              child: BiodataMapsScreen(from:widget.from,latitude: latitude,longtitude: longtitude,)));
    } else {
      AppExt.popScreen(context);
      BottomSheetFeedback.show(context,
          title: "Mohon Maaf", description: "Pastikan data terisi semua");
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
    blox = await bloc.getProfile();
    namaLengkapController.text = blox['data']['name'];
    alamatController.text = blox['data']['address'];
    checkInput();
  }

  void getProvinsi() {
    itemsProvinsi.clear();
    bloc.getProvinsi()
        .then((value) {
      List<ProvinsiModel> dataKolam = new List();
      setState(() {
        dataKolam = value;
        itemsProvinsi.addAll(dataKolam);

      });
    });
  }

  void getKota(String id_provinsi) {
    itemsKota.clear();
    bloc.getKota(id_provinsi)
        .then((value) {
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
    bloc.getKecamatan(id_kota)
        .then((value) {
      List<KecamatanModel> dataKolam = new List();
      setState(() {
        dataKolam = value;
        itemsKecamatan.addAll(dataKolam);
        Navigator.pop(context);
      });
    });
  }

  _getCurrentLocation()  async{
    Geolocation.enableLocationServices().then((result) {}).catchError((e) {});

    Geolocation.currentLocation(accuracy: LocationAccuracy.best)
        .listen((result) {
      if (result.isSuccessful) {
        setState(() {
          latitude = result.location.latitude;
          longtitude = result.location.longitude;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentLocation();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppbarForgot(
              context, "Aktivasi Akun ", Colors.white,widget.from),
              Expanded(child:
              SingleChildScrollView(
                  physics: new BouncingScrollPhysics(),
                  child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockVertical * 5,
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
                      onChanged: (val) {
                        checkInput();
                      },
                      controller: namaLengkapController,
                      decoration:
                      EditTextDecorationText(context, "", 20.0, 0, 0, 0),
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
                        top: SizeConfig.blockVertical * 1,
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
                    child:DropdownSearch<ProvinsiModel>(
                      searchBoxController: provinsiController,
                      items:itemsProvinsi,
                      mode: Mode.BOTTOM_SHEET,
                      isFilteredOnline: true,
                      showClearButton: true,
                      showSearchBox: true,
                      dropdownSearchDecoration:  EditTextDecorationText(context, "", 20.0, 0, 0, 0),
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: (ProvinsiModel u) =>
                      u == null ? "Provinsi Wajib di Isi " : null,
                      onChanged: (ProvinsiModel data) {
                        print(data.id);
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
                        top: SizeConfig.blockVertical * 1,
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
                    child:DropdownSearch<KotaModel>(
                      searchBoxController: kotaController,
                      items:itemsKota,
                      mode: Mode.BOTTOM_SHEET,
                      isFilteredOnline: true,
                      showClearButton: true,
                      showSearchBox: true,
                      dropdownSearchDecoration:  EditTextDecorationText(context, "", 20.0, 0, 0, 0),
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: (KotaModel u) =>
                      u == null ? "Kota Wajib di Isi " : null,
                      onChanged: (KotaModel data) {
                        print(data.cityId);
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
                        top: SizeConfig.blockVertical * 1,
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
                    child:DropdownSearch<KecamatanModel>(
                      searchBoxController: kecamatanController,
                      items:itemsKecamatan,
                      mode: Mode.BOTTOM_SHEET,
                      isFilteredOnline: true,
                      showClearButton: true,
                      showSearchBox: true,
                      dropdownSearchDecoration:  EditTextDecorationText(context, "", 20.0, 0, 0, 0),
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: (KecamatanModel u) =>
                      u == null ? "Kecamatan Wajib di Isi " : null,
                      onChanged: (KecamatanModel data) {
                        print(data.districtId);
                        setState(() {
                          selectedKecamatan = data.districtId;
                        });
                      },
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(
                  //       left: SizeConfig.blockVertical * 5,
                  //       top: SizeConfig.blockVertical * 1,
                  //       right: SizeConfig.blockVertical * 5),
                  //   child: Text(
                  //     "Kelurahan",
                  //     style: TextStyle(
                  //         color: appBarTextColor,
                  //         fontFamily: 'lato',
                  //         letterSpacing: 0.4,
                  //         fontSize: 14.0),
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.only(
                  //       left: SizeConfig.blockVertical * 5,
                  //       top: SizeConfig.blockVertical * 1,
                  //       right: SizeConfig.blockVertical * 5),
                  //   child: TextFormField(
                  //     onChanged: (val) {
                  //       checkInput();
                  //     },
                  //     controller: kelurahanController,
                  //     decoration:
                  //     EditTextDecorationText(context, "", 20.0, 0, 0, 0),
                  //     keyboardType: TextInputType.text,
                  //     style: TextStyle(
                  //         color: blackTextColor,
                  //         fontFamily: 'lato',
                  //         letterSpacing: 0.4,
                  //         fontSize: subTitleLogin),
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockVertical * 5,
                        top: SizeConfig.blockVertical * 1,
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
                      decoration:
                      EditTextDecorationText(context, "", 20.0, 0, 0, 0),
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
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    left: SizeConfig.blockVertical * 5,
                                    right: SizeConfig.blockVertical * 5,
                                    top: 15.0),
                                child: CustomElevation(
                                    height: 30.0,
                                    child: RaisedButton(
                                      highlightColor: colorPrimary,
                                      //Replace with actual colors
                                      color: isButtonEnabled
                                          ? colorPrimary
                                          : editTextBgColor,
                                      onPressed: () => {
                                          _toggleSimpan()

                                      },
                                      child: Text(
                                        isButtonEnabled
                                            ? "NEXT"
                                            : "Lengkapi data diatas",
                                        style: TextStyle(
                                            color: isButtonEnabled
                                                ? backgroundColor
                                                : blackTextColor,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'poppins',
                                            letterSpacing: 1.25,
                                            fontSize: 15.0),
                                      ),
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                        new BorderRadius.circular(30.0),
                                      ),
                                    )),
                              ),
                              Container(
                                height: 45.0,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    left: SizeConfig.blockVertical * 5,
                                    right: SizeConfig.blockVertical * 5,
                                    top: 15.0),
                                child: CustomElevation(
                                    height: 30.0,
                                    child: RaisedButton(
                                      highlightColor: redTextColor,
                                      //Replace with actual colors
                                      color: _clickForgot
                                          ? redTextColor
                                          : editTextBgColor,
                                      onPressed: () => {},
                                      child: Text(
                                        "Batal",
                                        style: TextStyle(
                                            color: _clickForgot
                                                ? backgroundColor
                                                : blackTextColor,
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
                              ),
                            ],
                          )))
                ],
              )))
        ],
      ),
    );


  }



}
