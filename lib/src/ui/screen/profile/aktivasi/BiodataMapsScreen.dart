import 'dart:async';

import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocation/geolocation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/aktivasi/BiodataScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/aktivasi/KtpScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/bloc/ProfilBloc.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LoadingDialog.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;
import 'package:page_transition/page_transition.dart';
class BiodataMapsScreen extends StatefulWidget {
  final String from;
  final double latitude;
  final double longtitude;

  const BiodataMapsScreen({Key key, this.from, this.latitude, this.longtitude}) : super(key: key);

  @override
  _BiodataMapsScreenState createState() => _BiodataMapsScreenState();
}

class _BiodataMapsScreenState extends State<BiodataMapsScreen> {
  GoogleMapController mapController;
  List<Marker> myMarker = [];
  double latitude = 0;
  double longitude = 0;
  String _resultAddress;
  String _resultDistrict;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {

    super.initState();
    _getCurrentLocation();


  }

  _getCurrentLocation()  async{
    Geolocation.enableLocationServices().then((result) {}).catchError((e) {});

    Geolocation.currentLocation(accuracy: LocationAccuracy.best)
        .listen((result) {
      if (result.isSuccessful) {
        setState(() {

          myMarker.add(Marker(
            position: LatLng(result.location.latitude,result.location.longitude),
            markerId: MarkerId("Lokasi Pertama"),
            onDragEnd: (dragEndPosition) {
              getSetAddress(Coordinates(
                  dragEndPosition.latitude, dragEndPosition.longitude));
            },

            infoWindow: InfoWindow(title: "Pilih Lokasi anda"),
            draggable: true,
          ));
        });
        getSetAddress(Coordinates(
            result.location.latitude, result.location.longitude));

      }
    });
  }

  getSetAddress(Coordinates coordinates) async {
    final addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      _resultAddress = addresses.first.addressLine;
      _resultDistrict = addresses.first.subLocality;
      latitude = coordinates.latitude;
      longitude = coordinates.longitude;
    });
  }

  void _toggleSimpan() async {
    LoadingDialog.show(context);
      var status = await bloc.funUpdateProfileLocation(
          latitude.toString(),
        longitude.toString(),
      );
      AppExt.popScreen(context);
      if(status){
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                // duration: Duration(microseconds: 1000),
                child: KtpScreen(from:widget.from)));
      }else{
        AppExt.popScreen(context);
        BottomSheetFeedback.show(context,
            title: "Mohon Maaf", description: "Silahkan ulangi Kembali");
      }


  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    return Scaffold(
      body: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: ScreenUtil().setHeight(1350),
              child:Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.latitude, widget.longtitude),
                      zoom: 20.0,
                    ),
                    markers: Set.from(myMarker),
                    mapType: MapType.normal,
                    onMapCreated: _onMapCreated,
                    onTap: _handleTap,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(150),left: ScreenUtil().setWidth(50)),
                    child: IconButton(icon: Icon(
                        Boxicons.bx_left_arrow_alt,
                        size: ScreenUtil(allowFontScaling: false)
                            .setSp(100)
                    ), onPressed: () {  Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            // duration: Duration(microseconds: 1000),
                            child: BiodataScreen(from:widget.from)));},),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Card(child:Container(
                padding: EdgeInsets.all(ScreenUtil().setHeight(50)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${_resultDistrict}",
                      style: h3.copyWith(color: textPrimary,
                          fontSize: ScreenUtil(allowFontScaling: false)
                              .setSp(70)),
                    ),
                    Text(
                      "${_resultAddress}",
                      style: h3.copyWith(color: Color(0xFF828282),
                          fontSize: ScreenUtil(allowFontScaling: false)
                              .setSp(35)),
                    ),
                    Container(
                      height: 45.0,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(70)),
                      child: CustomElevation(
                          height: 30.0,
                          child: RaisedButton(
                            highlightColor: colorPrimary,
                            color: colorPrimary,
                            onPressed: () =>
                            {_toggleSimpan()},
                            child: Text(
                              "Pilih Lokasi Ini",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'poppins',
                                  letterSpacing: 1.25,
                                  fontSize: ScreenUtil(allowFontScaling: false)
                                      .setSp(40)),
                            ),
                            shape: new RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(30.0),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  _handleTap(LatLng tappedPoint) {
    getSetAddress(Coordinates(
        tappedPoint.latitude, tappedPoint.longitude));
    setState(() {
      myMarker = [];
      myMarker.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        onDragEnd: (dragEndPosition) {
          getSetAddress(Coordinates(
              dragEndPosition.latitude, dragEndPosition.longitude));
        },
        infoWindow: InfoWindow(title: "Pilih Lokasi anda"),
        position: tappedPoint,
        draggable: true,
      ));
    });
  }
}
