import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:teleport/blocs/HomeBloc.dart';
import 'package:teleport/blocs/CommonSingleton.dart';
import 'package:teleport/common_utils/CodeConstants.dart';
import 'package:teleport/common_utils/SharedPref.dart';
import 'package:teleport/models/RideParamsModel.dart';
import 'package:teleport/ui/pages/functionality/RequestRideSheet.dart';
import 'package:teleport/ui/pages/functionality/AppDrawer.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

//TODO add bloc
void main() {
  runApp(MaterialApp(
    home: Home(),
  ));

}

class _HomeState extends State<Home> {
  GoogleMapController myController;
  BitmapDescriptor _markerIcon;
  var lat = 30.705860, lng = 76.708280;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  HomeBloc bloc = HomeBloc();

  @override
  void initState() {
    //    bloc.locationSetup();
    super.initState();
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, 'assets/images/bluedot.png')
          .then(_updateBitmap);
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }

  getLatLng() async {
    var location = new Location();
    location.onLocationChanged().listen((LocationData currentLocation) {
      setState(() {
        lat = currentLocation.latitude;
        lng = currentLocation.longitude;
      });
    });
    return lat;
  }

  @override
  Widget build(BuildContext context) {
    _createMarkerImageFromAsset(context);

    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: AppDrawer(),
        ),
        body: StreamBuilder(
          stream: bloc.allMarkers,
//          future: getLatLng(),
          builder:
              (context, AsyncSnapshot<Map<String, RideParamsModel>> snapshot) {
            if (snapshot.data != null) {
              Map<MarkerId, Marker> markers = Map();
              snapshot.data.forEach((id, rideParamsModel) {
                if (id == commonSingleton.id.value) {
                  MarkerId markerId = MarkerId(id);
                  final Marker marker = Marker(
                    markerId: markerId,
                    icon: _markerIcon,
                    draggable: false,
                    position: LatLng(
                      rideParamsModel.latitude,
                      rideParamsModel.longitude,
                    ),
                  );
                  markers[markerId] = marker;
                } else {
                  MarkerId markerId = MarkerId(id);
                  final Marker marker = Marker(
                    markerId: markerId,
                    draggable: false,
                    position: LatLng(
                      rideParamsModel.latitude,
                      rideParamsModel.longitude,
                    ),
                    onTap: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                          context: context,
                          builder: (builder) {
                            return RequestRideSheet(rideParamsModel);
                          });
                    },
                  );
                  markers[markerId] = marker;
                }
              });

              return Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  Container(
                    child: GoogleMap(
                      markers: Set<Marker>.of(markers.values),
                      onCameraMove: (map) {
//                        myController.getVisibleRegion().then((bounds) {
//                          print(bounds.northeast.longitude);
//                          print(bounds.southwest.longitude);
//                        });
                      },
                      onMapCreated: (controller) {
                        setState(() {
                          myController = controller;
                        });
                      },
                      onCameraIdle: () {
                        getVisibleRegion();
                      },
                      initialCameraPosition: CameraPosition(
                          target: LatLng(bloc.lat, bloc.lng), zoom: 10),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 22),
                    child: GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                        child: Image.asset(
                          "assets/images/menu.png",
                          scale: 2,
                        )),
                  )
                ],
              );
            } else {
              return Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                      ),
                      Text(
                        "Getting your location",
                        style: Theme.of(context).textTheme.body1,
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }

  getVisibleRegion() {
    myController.getVisibleRegion().then((bounds) {
//      print("Idl" + bounds.northeast.longitude.toString());
//      print("Idl" + bounds.southwest.longitude.toString());
      bloc.getDriversByRegion(
          bounds.northeast.longitude, bounds.southwest.longitude);
    });
  }
}
//Container();
