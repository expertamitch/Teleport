import 'package:flutter/material.dart';
import 'package:teleport/common_utils/Palette.dart';

class CustomRadio extends StatelessWidget {
  final RadioModel _item;
  CustomRadio(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50.0,
            width: 50.0,
            child: new Center(
              child: new Text(_item.text,
                  style: new TextStyle(
                      color:
                      _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 14.0)),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected
                  ? Palette.ocean_blue
                  : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected
                      ? Palette.ocean_blue
                      : Palette.darkPrimary),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: Image(image: AssetImage(_item.image)),
           )
        ],
      ),
    );
  }
}



class RadioModel {
  bool isSelected;
  final String image;
  final String text;

  RadioModel(this.isSelected, this.image, this.text);
}