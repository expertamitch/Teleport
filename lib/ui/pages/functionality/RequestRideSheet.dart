import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:teleport/blocs/CommonSingleton.dart';
import 'package:teleport/blocs/RequestRideSheetBloc.dart';
import 'package:teleport/common_utils/Palette.dart';
import 'package:teleport/models/RideParamsModel.dart';

class RequestRideSheet extends StatefulWidget {
  RideParamsModel rideParamsModel;

  RequestRideSheet(this.rideParamsModel);

  @override
  _RequestRideSheetState createState() => _RequestRideSheetState();
}

class _RequestRideSheetState extends State<RequestRideSheet> {
  RequestRideSheetBloc _requestRideSheetBloc = RequestRideSheetBloc();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var al = AppLocalizations.of(context);
    var data = EasyLocalizationProvider.of(context).data;

    return EasyLocalizationProvider(
      data: data,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
             children: <Widget>[
              getSizedBox(size.width * 0.1, 0.0),
              Container(
                width: size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    getSizedBox(0.0, 20.0),
                    Text(
                      al.tr("ride_params.title"),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle
                          .copyWith(color: Palette.primary),
                    ),
                    getSizedBox(0.0, 5.0),
                    Text(
                      al.tr("ride_params.min_price") +
                          " : " +
                          widget.rideParamsModel.minRidePrice +
                          " (${commonSingleton.getConvertedCurrency(widget.rideParamsModel.currency, double.parse(widget.rideParamsModel.minRidePrice))} ${commonSingleton.currency.value}) ",
                      style: Theme.of(context).textTheme.body2,
                    ),
                    getSizedBox(0.0, 5.0),
                    Text(
                      al.tr("ride_params.min_length") +
                          " : " +
                          widget.rideParamsModel.minRideLength,
                      style: Theme.of(context).textTheme.body2,
                    ),
                    getSizedBox(0.0, 5.0),
                    Text(
                      al.tr("ride_params.next_price") +
                          " : " +
                          widget.rideParamsModel.nextTimeBlocPrice,
                      style: Theme.of(context).textTheme.body2,
                    ),
                    getSizedBox(0.0, 5.0),
                    Text(
                      al.tr("ride_params.next_length") +
                          " : " +
                          widget.rideParamsModel.nextTimeBlocLength,
                      style: Theme.of(context).textTheme.body2,
                    ),
                    getSizedBox(0.0, 5.0),
                    Text(
                      al.tr("ride_params.currency") +
                          " : " +
                          widget.rideParamsModel.currency,
                      style: Theme.of(context).textTheme.body2,
                    ),
                    getSizedBox(0.0, 15.0),
                    StreamBuilder(
                      stream: _requestRideSheetBloc.isloading,
                      builder: (context, AsyncSnapshot<bool> snapshot) {
                        return Container(
                          margin: EdgeInsets.only(left: 50, right: 50),
                          decoration: new BoxDecoration(
                              gradient: LinearGradient(
                                //                          begin: Alignment.topRight,
//                          end: Alignment.bottomLeft,
                                colors: [
                                  // Colors are easy thanks to Flutter's Colors class.
                                  Palette.primary,
                                  Palette.primary2,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[500],
                                  offset: Offset(0.0, 1.5),
                                  blurRadius: 1.5,
                                ),
                              ],
                              borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(20.0),
                                  topRight: const Radius.circular(20.0),
                                  bottomLeft: const Radius.circular(20.0),
                                  bottomRight: const Radius.circular(20.0))),
                          child: Container(
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.all(12),
                              child: InkWell(
                                onTap: () {
                                  _requestRideSheetBloc.callCreateRide(
                                      widget.rideParamsModel, context);
                                },
                                child: Center(
                                  child: snapshot.data
                                      ? Container(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                          ),
                                          height: 20,
                                          width: 20,
                                        )
                                      : Text(
                                          al.tr("ride_params.request"),
                                          style: Theme.of(context).textTheme.button,
                                        ),
                                ),
                              )),
                        );
                      },
                    ),
                    getSizedBox(0.0, 15.0),

                  ],
                ),
              ),
              getSizedBox(size.width * 0.1, 0.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget getSizedBox(width, height) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
