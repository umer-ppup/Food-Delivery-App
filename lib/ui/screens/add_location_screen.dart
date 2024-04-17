import 'package:flutter/material.dart';
import 'package:food_delivery_app/resources/color_resources.dart';
import 'package:food_delivery_app/resources/font_resources.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';

class AddLocationScreen extends StatefulWidget {
  @override
  AddLocationScreenState createState() => AddLocationScreenState();
}

class AddLocationScreenState extends State<AddLocationScreen> {
  TextEditingController cAddress = TextEditingController();
  FocusNode _addressFocusNode = FocusNode();
  LatLng latlong = null;
  CameraPosition _cameraPosition;
  GoogleMapController _controller;
  Set<Marker> _markers={};
  List<Address> results = [];
  var myAddress;

  //region location functions
  Future getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
        return;
      }
      else{
        getLocation();
      }
    }
    else{
      getLocation();
    }
  }
  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);
    setState(() {
      latlong=new LatLng(position.latitude, position.longitude);
      _cameraPosition=CameraPosition(target:latlong, zoom: 18.0 );
      if(_controller!=null)
        _controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));

      _markers.add(Marker(markerId: MarkerId("a"),draggable:true,position: latlong,icon:
      BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed),onDragEnd: (_currentlatLng){
        latlong = _currentlatLng;

      }));
    });
  }
  void handelmarker(LatLng loc) {
    setState(() {
      _markers.add(Marker(markerId: MarkerId("a"),draggable:true,position: loc,icon:
      BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed),onDragEnd: (_currentlatLng){
        loc = _currentlatLng;
      }));
      latlong = loc;
    });
  }
  //endregion

  //region get address at a location
  getCurrentAddress() async {
    final coordinates = new Coordinates(latlong.latitude, latlong.longitude);
    results  = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = results.first;
    if(first!=null) {
      var address = "";
      if(first.featureName != null){
        address = first.featureName;
      }
      if(first.subLocality != null){
        address =   " $address, ${first.subLocality}" ;
      }
      if(first.subLocality != null){
        address =  " $address, ${first.subLocality}" ;
      }
      if(first.locality != null){
        address =  " $address, ${first.locality}" ;
      }
      if(first.countryName != null){
        address =  " $address, ${first.countryName}" ;
      }
      if(first.postalCode != null){
        address = " $address, ${first.postalCode}" ;
      }
      setState(() {
        myAddress = address;
        settingModalBottomSheet(context, myAddress);
      });
    }
  }
  //endregion

  //region address popup bottom sheet
  void settingModalBottomSheet(context, String text) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return StatefulBuilder(
              builder: (BuildContext mContext, StateSetter setState) {
                return Container(
                  child: Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                            text != null ? text : "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorResources.darkGreyColor,
                              fontFamily: FontResources.bold,
                            )
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        color: ColorResources.dodgerBlueColor,
                        onPressed: (){
                        },
                        child: Text(
                            "Confirm",
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorResources.whiteColor,
                              fontFamily: FontResources.bold,
                            )
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      )
                    ],
                  ),
                );
              });
        });
  }
  //endregion


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraPosition=CameraPosition(target: LatLng(0, 0),zoom: 15.0);
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            //region google map widget
            GoogleMap(
              initialCameraPosition: _cameraPosition,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              onTap: (value){
                handelmarker(value);
              },
              onMapCreated: (GoogleMapController controller){
                _controller=(controller);
                _controller.animateCamera(
                    CameraUpdate.newCameraPosition(_cameraPosition));
              },
              markers:_markers ,
              onCameraIdle: (){
                setState(() {

                });
              },
            ),
            //endregion

            //region back arrow
            Positioned(
              left: 10.0,
              top: 10.0,
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorResources.whiteColor,
                  ),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: ColorResources.darkGreyColor,
                    size: 24.0,
                    semanticLabel: 'Favourite.',
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            //endregion

            //region set current location button
            Positioned(
              right: 10.0,
              top: 10.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorResources.dodgerBlueColor,
                      ),
                      child: Icon(
                        Icons.location_on_rounded,
                        color: ColorResources.whiteColor,
                        size: 24.0,
                        semanticLabel: 'Favourite.',
                      ),
                    ),
                    onTap: () {
                      getCurrentLocation();
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: ColorResources.dodgerBlueColor,
                    onPressed: (){
                      getCurrentAddress();
                    },
                    child: Text(
                        'Get Address',
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorResources.whiteColor,
                          fontFamily: FontResources.bold,
                        )
                    ),
                  ),
                ],
              ),
            ),
            //endregion
          ],
        ),
      ),
    );
  }
}
