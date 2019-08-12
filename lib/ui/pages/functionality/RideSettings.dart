import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:teleport/blocs/RideSettingsBloc.dart';
import 'package:teleport/common_utils/Palette.dart';
import 'package:teleport/ui/widgets/CurrencyDropdown.dart';

class RideSettings extends StatefulWidget {
  @override
  _RideSettingsState createState() => _RideSettingsState();
}

class _RideSettingsState extends State<RideSettings> {
  RideSettingsBloc _bloc = RideSettingsBloc();
  TextEditingController _minimumPriceController = TextEditingController();
  TextEditingController _minimumLengthController = TextEditingController();
  TextEditingController _nextPriceController = TextEditingController();
  TextEditingController _nextLengthController = TextEditingController();
  String currencyValue = 'INR';
  String currencySymbol = '';
  GlobalKey<FormState> _formKey = GlobalKey();

  FocusNode _minPFocus = FocusNode();
  FocusNode _minLFocus = FocusNode();
  FocusNode _nextPFocus = FocusNode();
  FocusNode _nextLFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var al = AppLocalizations.of(context);
    var data = EasyLocalizationProvider.of(context).data;

    _onCurrencyChanged(val, symbol) {
      setState(() {
        print("cal$val");
        currencyValue = val;
        currencySymbol = symbol;
      });
    }

    Widget submitButton = StreamBuilder(
      stream: _bloc.isLoadingController,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        return Container(
          margin: EdgeInsets.only(
              left: size.width * 0.27, right: size.width * 0.27),
          decoration: new BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Palette.primary,
                  Palette.primary2,
                ],
              ),
              borderRadius: new BorderRadius.all(const Radius.circular(20.0))),
          child: InkWell(
            onTap: () {
              _bloc.currencyController.value = currencyValue;
//              if (_formKey.currentState.validate()) {
//                _formKey.currentState.save();

              print(_bloc.currencyController.value);
              _bloc.submit(context);
//              }
            },
            splashColor: Colors.white30,
            child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(12),
              child: snapshot.data
                  ? Container(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                      height: 20,
                      width: 20,
                    )
                  : Text(al.tr("ride_settings.save"),
                      style: Theme.of(context).textTheme.button),
            ),
          ),
        );
      },
    );

    Widget currencyDropDown = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Currency'),
        CurrencyDropDown(
            currencyValue: currencyValue, onChanged: _onCurrencyChanged),
      ],
    );

    Widget minimumPrice = StreamBuilder(
      stream: _bloc.minimumRidePrice,
      builder: (context, AsyncSnapshot<String> snapshot) {
        _minimumPriceController.value =
            _minimumPriceController.value.copyWith(text: snapshot.data);
        return TextField(
            textInputAction: TextInputAction.next,
            focusNode: _minPFocus,
            onSubmitted: (value) {
              _minPFocus.unfocus();
              FocusScope.of(context).requestFocus(_minLFocus);
            },
            controller: _minimumPriceController,
            onChanged: _bloc.changeMinimumPrice,
//            validator: _bloc.fieldValidator,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.start,
            style: new TextStyle(
                fontFamily: "SourceSansPro",
                color: Colors.black,
                height: 0.2,
                fontSize: 14),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.black, fontSize: 14),
              fillColor: Colors.white,
              errorText: snapshot.error,
              labelText: al.tr("ride_settings.min_price"),
              focusedBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Palette.primary800, width: 1.3),
              ),
              enabledBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Palette.primary400, width: 1.0),
              ),
              border: OutlineInputBorder(),
            ));
      },
    );


    Widget nextTimeLength = StreamBuilder(
      stream: _bloc.nextTimeBlocLength,
      builder: (context, AsyncSnapshot<String> snapshot) {
        _nextLengthController.value =
            _nextLengthController.value.copyWith(text: snapshot.data);
        return TextField(
            textInputAction: TextInputAction.done,
            focusNode: _nextLFocus,
            onSubmitted: (value) {
              _nextLFocus.unfocus();
            },
            controller: _nextLengthController,
            onChanged: _bloc.changeNextTimeBlocLength,
//            validator: _bloc.fieldValidator,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.start,
            style: new TextStyle(
                fontFamily: "SourceSansPro",
                color: Colors.black,
                height: 0.2,
                fontSize: 14),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.black, fontSize: 14),
              fillColor: Colors.white,
              errorText: snapshot.error,
              labelText: al.tr("ride_settings.next_length"),
              focusedBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Palette.primary800, width: 1.3),
              ),
              enabledBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Palette.primary400, width: 1.0),
              ),
              border: OutlineInputBorder(),
            ));
      },
    );

    Widget minimumLength = StreamBuilder(
      stream: _bloc.minimumRideLength,
      builder: (context, AsyncSnapshot<String> snapshot) {
        _minimumLengthController.value =
            _minimumLengthController.value.copyWith(text: snapshot.data);
        return TextField(
            textInputAction: TextInputAction.next,
            focusNode: _minLFocus,
            onSubmitted: (value) {
              _minLFocus.unfocus();
              FocusScope.of(context).requestFocus(_nextPFocus);
            },
            controller: _minimumLengthController,
            onChanged: _bloc.changeMinimumlength,
//            validator: _bloc.fieldValidator,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.start,
            style: new TextStyle(
                fontFamily: "SourceSansPro",
                color: Colors.black,
                height: 0.2,
                fontSize: 14),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.black, fontSize: 14),
              fillColor: Colors.white,
              errorText: snapshot.error,
              labelText: al.tr("ride_settings.min_length"),
              focusedBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Palette.primary800, width: 1.3),
              ),
              enabledBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Palette.primary400, width: 1.0),
              ),
              border: OutlineInputBorder(),
            ));
      },
    );


    Widget nextTimePrice = StreamBuilder(
      stream: _bloc.nextTimeBlocPrice,
      builder: (context, AsyncSnapshot<String> snapshot) {
        _nextPriceController.value =
            _nextPriceController.value.copyWith(text: snapshot.data);
        return TextField(
            controller: _nextPriceController,
            onChanged: _bloc.changeNextTimeBlocPrice,
//            validator: _bloc.fieldValidator,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.start,
            style: new TextStyle(
                fontFamily: "SourceSansPro",
                color: Colors.black,
                height: 0.2,
                fontSize: 14),
            textInputAction: TextInputAction.next,
            focusNode: _nextPFocus,
            onSubmitted: (value) {
              _nextPFocus.unfocus();
              FocusScope.of(context).requestFocus(_nextLFocus);

            },
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.black, fontSize: 14),
              fillColor: Colors.white,
              errorText: snapshot.error,
                labelText: al.tr("ride_settings.next_price"),
              focusedBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Palette.primary800, width: 1.3),
              ),
              enabledBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Palette.primary400, width: 1.0),
              ),
              border: OutlineInputBorder(),
            ));
      },
    );


    Widget body = Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          getSizedBox(0.0, 10.0),
          Row(
            children: <Widget>[
              getSizedBox(size.width * 0.05, 0.0),
              Text(
                al.tr("ride_settings.info"),
                style: Theme.of(context).textTheme.body1,
              ),
            ],
          ),
          getSizedBox(0.0, 20.0),
          Row(
            children: <Widget>[
              getSizedBox(size.width * 0.15, 0.0),
              Container(width: size.width * 0.7, child: minimumPrice)
            ],
          ),
          getSizedBox(0.0, 20.0),
          Row(
            children: <Widget>[
              getSizedBox(size.width * 0.15, 0.0),
              Container(width: size.width * 0.7, child: minimumLength)
            ],
          ),
          getSizedBox(0.0, 20.0),
          Row(
            children: <Widget>[
              getSizedBox(size.width * 0.15, 0.0),
              Container(width: size.width * 0.7, child: nextTimePrice)
            ],
          ),
          getSizedBox(0.0, 20.0),
          Row(
            children: <Widget>[
              getSizedBox(size.width * 0.15, 0.0),
              Container(width: size.width * 0.7, child: nextTimeLength)
            ],
          ),
          getSizedBox(0.0, 20.0),
          Row(
            children: <Widget>[
              getSizedBox(size.width * 0.15, 0.0),
              Container(width: size.width * 0.7, child: currencyDropDown)
            ],
          ),
          getSizedBox(0.0, 40.0),
          submitButton
        ],
      ),
    );

    if(_bloc.currencyController.value!=null){
      currencyValue=_bloc.currencyController.value;
    }

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
            al.tr("ride_settings.title"),
            style: Theme.of(context)
                .textTheme
                .subtitle
                .copyWith(color: Colors.white),
          ),
        ),
        body: ListView(
          children: <Widget>[body],
          scrollDirection: Axis.vertical,
        ),
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
