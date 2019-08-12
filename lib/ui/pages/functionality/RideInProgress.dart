import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';

class RideInProgress extends StatefulWidget {
  @override
  _RideInProgressState createState() => _RideInProgressState();
}

class _RideInProgressState extends State<RideInProgress> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var al = AppLocalizations.of(context);
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            al.tr("ride_in_progress.title"),
            style: Theme.of(context)
                .textTheme
                .subtitle
                .copyWith(color: Colors.white),
          ),
        ),
        body: Center(
          child: Text(
            al.tr("ride_in_progress.ride_in_progress"),
            style: Theme.of(context).textTheme.body2,
          ),
        ),
      ),
    );
  }
}
