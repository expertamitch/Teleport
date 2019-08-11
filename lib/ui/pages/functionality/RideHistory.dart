import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:teleport/common_utils/Palette.dart';

class RideHistory extends StatefulWidget {
  @override
  _RideHistoryState createState() => _RideHistoryState();
}

class _RideHistoryState extends State<RideHistory> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var al = AppLocalizations.of(context);
    var data = EasyLocalizationProvider.of(context).data;

    var item = Card(child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Chandigarh to Amritsar",
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(color: Palette.primary)),
                getSizedBox(0.0, 4.0),
                Text("Ridden by Amit Kumar",
                    style: Theme.of(context).textTheme.body2),
                getSizedBox(0.0, 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("20 Jan 2019, 10:27 pm",
                        style: Theme.of(context).textTheme.body1),
                    Text("Paid 20 USD",
                        style: Theme.of(context).textTheme.body1)
                  ],
                )
              ]),
        )) , elevation: 1,);

    var list = ListView.builder(
        padding: EdgeInsets.only(bottom: 10),
        itemCount: 12,
        itemBuilder: (context, i) {
//          var values = snapshot.data[i];
          return item;
        });

    var tabs = DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              child: Icon(Icons.arrow_back_ios),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                    text: al.tr("ride_history.rides"),
                    icon: Container(
                      child: Image(image: AssetImage("assets/images/taxi.png")),
                      width: 40,
                      height: 40,
                    )),
                Tab(
                    text: al.tr("ride_history.hired"),
                    icon: Container(
                      child: Image(image: AssetImage("assets/images/hire.png")),
                      width: 40,
                      height: 40,
                    )),
              ],
            ),
            title: Text(al.tr("ride_history.title")),
          ),
          body: TabBarView(
            children: [
              list,
              list,
            ],
          ),
        ));

    return EasyLocalizationProvider(data: data, child: tabs);
  }

  Widget getSizedBox(width, height) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
