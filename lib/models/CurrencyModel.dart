import 'dart:convert';

import 'package:teleport/common_utils/CodeConstants.dart';

class CurrencyModel {
  Rates rates;

  CurrencyModel({this.rates});

  factory CurrencyModel.fromJson(Map<dynamic, dynamic> json) {
    CurrencyModel cm = CurrencyModel();
    if (json['rates'] != null) {
      try {
        cm.rates = Rates.fromJson(json['rates']);
      } catch (e) {
        var map = JsonCodec().decode(json['rates']);
        cm.rates = Rates.fromJson(map);
      }
    } else
      cm.rates = null;

    return cm;

    return CurrencyModel(
      rates: json['rates'] != null ? Rates.fromJson(json['rates']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<dynamic, dynamic>();
    if (this.rates != null) {
      data['rates'] = this.rates.toJson();
    }
    return data;
  }

  static CurrencyModel stringToObject(String json) {
    var data = JsonCodec().decode(json) as Map<String, dynamic>;
    return CurrencyModel.fromJson(data);
  }

}

class Rates {
  String base;
  String disclaimer;
  String license;
  RatesX rates;
  int timestamp;

  Rates({this.base, this.disclaimer, this.license, this.rates, this.timestamp});

  factory Rates.fromJson(Map<String, dynamic> json) {
    Rates rates = Rates();
    rates.base = json['base'];
    rates.disclaimer = json['disclaimer'];
    rates.license = json['license'];
    rates.timestamp = json['timestamp'];

    if (json['rates'] != null) {
      try {
        rates.rates = RatesX.fromJson(json['rates']);
      } catch (e) {
        var map = JsonCodec().decode(json['rates']);
        rates.rates = RatesX.fromJson(map);
      }
    } else
      rates.rates = null;

    return rates;
//    rates.rates=rates json['rates'] != null ? RatesX.fromJson(json['rates']) : null;

    return Rates(
      base: json['base'],
      disclaimer: json['disclaimer'],
      license: json['license'],
      rates: json['rates'] != null ? RatesX.fromJson(json['rates']) : null,
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<dynamic, dynamic>();
    data['base'] = this.base;
    data['disclaimer'] = this.disclaimer;
    data['license'] = this.license;
    data['timestamp'] = this.timestamp;
    if (this.rates != null) {
      data['rates'] = this.rates.toJson();
    }
    return data;
  }
}

class RatesX {
  double AED;
  double AFN;
  double ALL;
  double AMD;
  double ANG;
  double AOA;
  double ARS;
  double AUD;
  double AWG;
  double AZN;
  double BAM;
  double BBD;
  double BDT;
  double BGN;
  double BHD;
  double BIF;
  double BMD;
  double BND;
  double BOB;
  double BRL;
  double BSD;
  double BTC;
  double BTN;
  double BWP;
  double BYN;
  double BZD;
  double CAD;
  double CDF;
  double CHF;
  double CLF;
  double CLP;
  double CNH;
  double CNY;
  double COP;
  double CRC;
  double CUC;
  double CUP;
  double CVE;
  double CZK;
  double DJF;
  double DKK;
  double DOP;
  double DZD;
  double EGP;
  double ERN;
  double ETB;
  double EUR;
  double FJD;
  double FKP;
  double GBP;
  double GEL;
  double GGP;
  double GHS;
  double GIP;
  double GMD;
  double GNF;
  double GTQ;
  double GYD;
  double HKD;
  double HNL;
  double HRK;
  double HTG;
  double HUF;
  double IDR;
  double ILS;
  double IMP;
  double INR;
  double IQD;
  double IRR;
  double ISK;
  double JEP;
  double JMD;
  double JOD;
  double JPY;
  double KES;
  double KGS;
  double KHR;
  double KMF;
  double KPW;
  double KRW;
  double KWD;
  double KYD;
  double KZT;
  double LAK;
  double LBP;
  double LKR;
  double LRD;
  double LSL;
  double LYD;
  double MAD;
  double MDL;
  double MGA;
  double MKD;
  double MMK;
  double MNT;
  double MOP;
  double MRO;
  double MRU;
  double MUR;
  double MVR;
  double MWK;
  double MXN;
  double MYR;
  double MZN;
  double NAD;
  double NGN;
  double NIO;
  double NOK;
  double NPR;
  double NZD;
  double OMR;
  double PAB;
  double PEN;
  double PGK;
  double PHP;
  double PKR;
  double PLN;
  double PYG;
  double QAR;
  double RON;
  double RSD;
  double RUB;
  double RWF;
  double SAR;
  double SBD;
  double SCR;
  double SDG;
  double SEK;
  double SGD;
  double SHP;
  double SLL;
  double SOS;
  double SRD;
  double SSP;
  double STD;
  double STN;
  double SVC;
  double SYP;
  double SZL;
  double THB;
  double TJS;
  double TMT;
  double TND;
  double TOP;
  double TRY;
  double TTD;
  double TWD;
  double TZS;
  double UAH;
  double UGX;
  double USD;
  double UYU;
  double UZS;
  double VEF;
  double VES;
  double VND;
  double VUV;
  double WST;
  double XAF;
  double XAG;
  double XAU;
  double XCD;
  double XDR;
  double XOF;
  double XPD;
  double XPF;
  double XPT;
  double YER;
  double ZAR;
  double ZMW;
  double ZWL;

  RatesX(
      {this.AED,
      this.AFN,
      this.ALL,
      this.AMD,
      this.ANG,
      this.AOA,
      this.ARS,
      this.AUD,
      this.AWG,
      this.AZN,
      this.BAM,
      this.BBD,
      this.BDT,
      this.BGN,
      this.BHD,
      this.BIF,
      this.BMD,
      this.BND,
      this.BOB,
      this.BRL,
      this.BSD,
      this.BTC,
      this.BTN,
      this.BWP,
      this.BYN,
      this.BZD,
      this.CAD,
      this.CDF,
      this.CHF,
      this.CLF,
      this.CLP,
      this.CNH,
      this.CNY,
      this.COP,
      this.CRC,
      this.CUC,
      this.CUP,
      this.CVE,
      this.CZK,
      this.DJF,
      this.DKK,
      this.DOP,
      this.DZD,
      this.EGP,
      this.ERN,
      this.ETB,
      this.EUR,
      this.FJD,
      this.FKP,
      this.GBP,
      this.GEL,
      this.GGP,
      this.GHS,
      this.GIP,
      this.GMD,
      this.GNF,
      this.GTQ,
      this.GYD,
      this.HKD,
      this.HNL,
      this.HRK,
      this.HTG,
      this.HUF,
      this.IDR,
      this.ILS,
      this.IMP,
      this.INR,
      this.IQD,
      this.IRR,
      this.ISK,
      this.JEP,
      this.JMD,
      this.JOD,
      this.JPY,
      this.KES,
      this.KGS,
      this.KHR,
      this.KMF,
      this.KPW,
      this.KRW,
      this.KWD,
      this.KYD,
      this.KZT,
      this.LAK,
      this.LBP,
      this.LKR,
      this.LRD,
      this.LSL,
      this.LYD,
      this.MAD,
      this.MDL,
      this.MGA,
      this.MKD,
      this.MMK,
      this.MNT,
      this.MOP,
      this.MRO,
      this.MRU,
      this.MUR,
      this.MVR,
      this.MWK,
      this.MXN,
      this.MYR,
      this.MZN,
      this.NAD,
      this.NGN,
      this.NIO,
      this.NOK,
      this.NPR,
      this.NZD,
      this.OMR,
      this.PAB,
      this.PEN,
      this.PGK,
      this.PHP,
      this.PKR,
      this.PLN,
      this.PYG,
      this.QAR,
      this.RON,
      this.RSD,
      this.RUB,
      this.RWF,
      this.SAR,
      this.SBD,
      this.SCR,
      this.SDG,
      this.SEK,
      this.SGD,
      this.SHP,
      this.SLL,
      this.SOS,
      this.SRD,
      this.SSP,
      this.STD,
      this.STN,
      this.SVC,
      this.SYP,
      this.SZL,
      this.THB,
      this.TJS,
      this.TMT,
      this.TND,
      this.TOP,
      this.TRY,
      this.TTD,
      this.TWD,
      this.TZS,
      this.UAH,
      this.UGX,
      this.USD,
      this.UYU,
      this.UZS,
      this.VEF,
      this.VES,
      this.VND,
      this.VUV,
      this.WST,
      this.XAF,
      this.XAG,
      this.XAU,
      this.XCD,
      this.XDR,
      this.XOF,
      this.XPD,
      this.XPF,
      this.XPT,
      this.YER,
      this.ZAR,
      this.ZMW,
      this.ZWL});

  factory RatesX.fromJson(Map<String, dynamic> json) {
    return RatesX(
      AED: double.parse(json['AED'].toString()),
      AFN: double.parse(json['AFN'].toString()),
      ALL: double.parse(json['ALL'].toString()),
      AMD: double.parse(json['AMD'].toString()),
      ANG: double.parse(json['ANG'].toString()),
      AOA: double.parse(json['AOA'].toString()),
      ARS: double.parse(json['ARS'].toString()),
      AUD: double.parse(json['AUD'].toString()),
      AWG: double.parse(json['AWG'].toString()),
      AZN: double.parse(json['AZN'].toString()),
      BAM: double.parse(json['BAM'].toString()),
      BBD: double.parse(json['BBD'].toString()),
      BDT: double.parse(json['BDT'].toString()),
      BGN: double.parse(json['BGN'].toString()),
      BHD: double.parse(json['BHD'].toString()),
      BIF: double.parse(json['BIF'].toString()),
      BMD: double.parse(json['BMD'].toString()),
      BND: double.parse(json['BND'].toString()),
      BOB: double.parse(json['BOB'].toString()),
      BRL: double.parse(json['BRL'].toString()),
      BSD: double.parse(json['BSD'].toString()),
      BTC: double.parse(json['BTC'].toString()),
      BTN: double.parse(json['BTN'].toString()),
      BWP: double.parse(json['BWP'].toString()),
      BYN: double.parse(json['BYN'].toString()),
      BZD: double.parse(json['BZD'].toString()),
      CAD: double.parse(json['CAD'].toString()),
      CDF: double.parse(json['CDF'].toString()),
      CHF: double.parse(json['CHF'].toString()),
      CLF: double.parse(json['CLF'].toString()),
      CLP: double.parse(json['CLP'].toString()),
      CNH: double.parse(json['CNH'].toString()),
      CNY: double.parse(json['CNY'].toString()),
      COP: double.parse(json['COP'].toString()),
      CRC: double.parse(json['CRC'].toString()),
      CUC: double.parse(json['CUC'].toString()),
      CUP: double.parse(json['CUP'].toString()),
      CVE: double.parse(json['CVE'].toString()),
      CZK: double.parse(json['CZK'].toString()),
      DJF: double.parse(json['DJF'].toString()),
      DKK: double.parse(json['DKK'].toString()),
      DOP: double.parse(json['DOP'].toString()),
      DZD: double.parse(json['DZD'].toString()),
      EGP: double.parse(json['EGP'].toString()),
      ERN: double.parse(json['ERN'].toString()),
      ETB: double.parse(json['ETB'].toString()),
      EUR: double.parse(json['EUR'].toString()),
      FJD: double.parse(json['FJD'].toString()),
      FKP: double.parse(json['FKP'].toString()),
      GBP: double.parse(json['GBP'].toString()),
      GEL: double.parse(json['GEL'].toString()),
      GGP: double.parse(json['GGP'].toString()),
      GHS: double.parse(json['GHS'].toString()),
      GIP: double.parse(json['GIP'].toString()),
      GMD: double.parse(json['GMD'].toString()),
      GNF: double.parse(json['GNF'].toString()),
      GTQ: double.parse(json['GTQ'].toString()),
      GYD: double.parse(json['GYD'].toString()),
      HKD: double.parse(json['HKD'].toString()),
      HNL: double.parse(json['HNL'].toString()),
      HRK: double.parse(json['HRK'].toString()),
      HTG: double.parse(json['HTG'].toString()),
      HUF: double.parse(json['HUF'].toString()),
      IDR: double.parse(json['IDR'].toString()),
      ILS: double.parse(json['ILS'].toString()),
      IMP: double.parse(json['IMP'].toString()),
      INR: double.parse(json['INR'].toString()),
      IQD: double.parse(json['IQD'].toString()),
      IRR: double.parse(json['IRR'].toString()),
      ISK: double.parse(json['ISK'].toString()),
      JEP: double.parse(json['JEP'].toString()),
      JMD: double.parse(json['JMD'].toString()),
      JOD: double.parse(json['JOD'].toString()),
      JPY: double.parse(json['JPY'].toString()),
      KES: double.parse(json['KES'].toString()),
      KGS: double.parse(json['KGS'].toString()),
      KHR: double.parse(json['KHR'].toString()),
      KMF: double.parse(json['KMF'].toString()),
      KPW: double.parse(json['KPW'].toString()),
      KRW: double.parse(json['KRW'].toString()),
      KWD: double.parse(json['KWD'].toString()),
      KYD: double.parse(json['KYD'].toString()),
      KZT: double.parse(json['KZT'].toString()),
      LAK: double.parse(json['LAK'].toString()),
      LBP: double.parse(json['LBP'].toString()),
      LKR: double.parse(json['LKR'].toString()),
      LRD: double.parse(json['LRD'].toString()),
      LSL: double.parse(json['LSL'].toString()),
      LYD: double.parse(json['LYD'].toString()),
      MAD: double.parse(json['MAD'].toString()),
      MDL: double.parse(json['MDL'].toString()),
      MGA: double.parse(json['MGA'].toString()),
      MKD: double.parse(json['MKD'].toString()),
      MMK: double.parse(json['MMK'].toString()),
      MNT: double.parse(json['MNT'].toString()),
      MOP: double.parse(json['MOP'].toString()),
      MRO: double.parse(json['MRO'].toString()),
      MRU: double.parse(json['MRU'].toString()),
      MUR: double.parse(json['MUR'].toString()),
      MVR: double.parse(json['MVR'].toString()),
      MWK: double.parse(json['MWK'].toString()),
      MXN: double.parse(json['MXN'].toString()),
      MYR: double.parse(json['MYR'].toString()),
      MZN: double.parse(json['MZN'].toString()),
      NAD: double.parse(json['NAD'].toString()),
      NGN: double.parse(json['NGN'].toString()),
      NIO: double.parse(json['NIO'].toString()),
      NOK: double.parse(json['NOK'].toString()),
      NPR: double.parse(json['NPR'].toString()),
      NZD: double.parse(json['NZD'].toString()),
      OMR: double.parse(json['OMR'].toString()),
      PAB: double.parse(json['PAB'].toString()),
      PEN: double.parse(json['PEN'].toString()),
      PGK: double.parse(json['PGK'].toString()),
      PHP: double.parse(json['PHP'].toString()),
      PKR: double.parse(json['PKR'].toString()),
      PLN: double.parse(json['PLN'].toString()),
      PYG: double.parse(json['PYG'].toString()),
      QAR: double.parse(json['QAR'].toString()),
      RON: double.parse(json['RON'].toString()),
      RSD: double.parse(json['RSD'].toString()),
      RUB: double.parse(json['RUB'].toString()),
      RWF: double.parse(json['RWF'].toString()),
      SAR: double.parse(json['SAR'].toString()),
      SBD: double.parse(json['SBD'].toString()),
      SCR: double.parse(json['SCR'].toString()),
      SDG: double.parse(json['SDG'].toString()),
      SEK: double.parse(json['SEK'].toString()),
      SGD: double.parse(json['SGD'].toString()),
      SHP: double.parse(json['SHP'].toString()),
      SLL: double.parse(json['SLL'].toString()),
      SOS: double.parse(json['SOS'].toString()),
      SRD: double.parse(json['SRD'].toString()),
      SSP: double.parse(json['SSP'].toString()),
      STD: double.parse(json['STD'].toString()),
      STN: double.parse(json['STN'].toString()),
      SVC: double.parse(json['SVC'].toString()),
      SYP: double.parse(json['SYP'].toString()),
      SZL: double.parse(json['SZL'].toString()),
      THB: double.parse(json['THB'].toString()),
      TJS: double.parse(json['TJS'].toString()),
      TMT: double.parse(json['TMT'].toString()),
      TND: double.parse(json['TND'].toString()),
      TOP: double.parse(json['TOP'].toString()),
      TRY: double.parse(json['TRY'].toString()),
      TTD: double.parse(json['TTD'].toString()),
      TWD: double.parse(json['TWD'].toString()),
      TZS: double.parse(json['TZS'].toString()),
      UAH: double.parse(json['UAH'].toString()),
      UGX: double.parse(json['UGX'].toString()),
      USD: double.parse(json['USD'].toString()),
      UYU: double.parse(json['UYU'].toString()),
      UZS: double.parse(json['UZS'].toString()),
      VEF: double.parse(json['VEF'].toString()),
      VES: double.parse(json['VES'].toString()),
      VND: double.parse(json['VND'].toString()),
      VUV: double.parse(json['VUV'].toString()),
      WST: double.parse(json['WST'].toString()),
      XAF: double.parse(json['XAF'].toString()),
      XAG: double.parse(json['XAG'].toString()),
      XAU: double.parse(json['XAU'].toString()),
      XCD: double.parse(json['XCD'].toString()),
      XDR: double.parse(json['XDR'].toString()),
      XOF: double.parse(json['XOF'].toString()),
      XPD: double.parse(json['XPD'].toString()),
      XPF: double.parse(json['XPF'].toString()),
      XPT: double.parse(json['XPT'].toString()),
      YER: double.parse(json['YER'].toString()),
      ZAR: double.parse(json['ZAR'].toString()),
      ZMW: double.parse(json['ZMW'].toString()),
      ZWL: double.parse(json['ZWL'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AED'] = this.AED;
    data['AFN'] = this.AFN;
    data['ALL'] = this.ALL;
    data['AMD'] = this.AMD;
    data['ANG'] = this.ANG;
    data['AOA'] = this.AOA;
    data['ARS'] = this.ARS;
    data['AUD'] = this.AUD;
    data['AWG'] = this.AWG;
    data['AZN'] = this.AZN;
    data['BAM'] = this.BAM;
    data['BBD'] = this.BBD;
    data['BDT'] = this.BDT;
    data['BGN'] = this.BGN;
    data['BHD'] = this.BHD;
    data['BIF'] = this.BIF;
    data['BMD'] = this.BMD;
    data['BND'] = this.BND;
    data['BOB'] = this.BOB;
    data['BRL'] = this.BRL;
    data['BSD'] = this.BSD;
    data['BTC'] = this.BTC;
    data['BTN'] = this.BTN;
    data['BWP'] = this.BWP;
    data['BYN'] = this.BYN;
    data['BZD'] = this.BZD;
    data['CAD'] = this.CAD;
    data['CDF'] = this.CDF;
    data['CHF'] = this.CHF;
    data['CLF'] = this.CLF;
    data['CLP'] = this.CLP;
    data['CNH'] = this.CNH;
    data['CNY'] = this.CNY;
    data['COP'] = this.COP;
    data['CRC'] = this.CRC;
    data['CUC'] = this.CUC;
    data['CUP'] = this.CUP;
    data['CVE'] = this.CVE;
    data['CZK'] = this.CZK;
    data['DJF'] = this.DJF;
    data['DKK'] = this.DKK;
    data['DOP'] = this.DOP;
    data['DZD'] = this.DZD;
    data['EGP'] = this.EGP;
    data['ERN'] = this.ERN;
    data['ETB'] = this.ETB;
    data['EUR'] = this.EUR;
    data['FJD'] = this.FJD;
    data['FKP'] = this.FKP;
    data['GBP'] = this.GBP;
    data['GEL'] = this.GEL;
    data['GGP'] = this.GGP;
    data['GHS'] = this.GHS;
    data['GIP'] = this.GIP;
    data['GMD'] = this.GMD;
    data['GNF'] = this.GNF;
    data['GTQ'] = this.GTQ;
    data['GYD'] = this.GYD;
    data['HKD'] = this.HKD;
    data['HNL'] = this.HNL;
    data['HRK'] = this.HRK;
    data['HTG'] = this.HTG;
    data['HUF'] = this.HUF;
    data['IDR'] = this.IDR;
    data['ILS'] = this.ILS;
    data['IMP'] = this.IMP;
    data['INR'] = this.INR;
    data['IQD'] = this.IQD;
    data['IRR'] = this.IRR;
    data['ISK'] = this.ISK;
    data['JEP'] = this.JEP;
    data['JMD'] = this.JMD;
    data['JOD'] = this.JOD;
    data['JPY'] = this.JPY;
    data['KES'] = this.KES;
    data['KGS'] = this.KGS;
    data['KHR'] = this.KHR;
    data['KMF'] = this.KMF;
    data['KPW'] = this.KPW;
    data['KRW'] = this.KRW;
    data['KWD'] = this.KWD;
    data['KYD'] = this.KYD;
    data['KZT'] = this.KZT;
    data['LAK'] = this.LAK;
    data['LBP'] = this.LBP;
    data['LKR'] = this.LKR;
    data['LRD'] = this.LRD;
    data['LSL'] = this.LSL;
    data['LYD'] = this.LYD;
    data['MAD'] = this.MAD;
    data['MDL'] = this.MDL;
    data['MGA'] = this.MGA;
    data['MKD'] = this.MKD;
    data['MMK'] = this.MMK;
    data['MNT'] = this.MNT;
    data['MOP'] = this.MOP;
    data['MRO'] = this.MRO;
    data['MRU'] = this.MRU;
    data['MUR'] = this.MUR;
    data['MVR'] = this.MVR;
    data['MWK'] = this.MWK;
    data['MXN'] = this.MXN;
    data['MYR'] = this.MYR;
    data['MZN'] = this.MZN;
    data['NAD'] = this.NAD;
    data['NGN'] = this.NGN;
    data['NIO'] = this.NIO;
    data['NOK'] = this.NOK;
    data['NPR'] = this.NPR;
    data['NZD'] = this.NZD;
    data['OMR'] = this.OMR;
    data['PAB'] = this.PAB;
    data['PEN'] = this.PEN;
    data['PGK'] = this.PGK;
    data['PHP'] = this.PHP;
    data['PKR'] = this.PKR;
    data['PLN'] = this.PLN;
    data['PYG'] = this.PYG;
    data['QAR'] = this.QAR;
    data['RON'] = this.RON;
    data['RSD'] = this.RSD;
    data['RUB'] = this.RUB;
    data['RWF'] = this.RWF;
    data['SAR'] = this.SAR;
    data['SBD'] = this.SBD;
    data['SCR'] = this.SCR;
    data['SDG'] = this.SDG;
    data['SEK'] = this.SEK;
    data['SGD'] = this.SGD;
    data['SHP'] = this.SHP;
    data['SLL'] = this.SLL;
    data['SOS'] = this.SOS;
    data['SRD'] = this.SRD;
    data['SSP'] = this.SSP;
    data['STD'] = this.STD;
    data['STN'] = this.STN;
    data['SVC'] = this.SVC;
    data['SYP'] = this.SYP;
    data['SZL'] = this.SZL;
    data['THB'] = this.THB;
    data['TJS'] = this.TJS;
    data['TMT'] = this.TMT;
    data['TND'] = this.TND;
    data['TOP'] = this.TOP;
    data['TRY'] = this.TRY;
    data['TTD'] = this.TTD;
    data['TWD'] = this.TWD;
    data['TZS'] = this.TZS;
    data['UAH'] = this.UAH;
    data['UGX'] = this.UGX;
    data['USD'] = this.USD;
    data['UYU'] = this.UYU;
    data['UZS'] = this.UZS;
    data['VEF'] = this.VEF;
    data['VES'] = this.VES;
    data['VND'] = this.VND;
    data['VUV'] = this.VUV;
    data['WST'] = this.WST;
    data['XAF'] = this.XAF;
    data['XAG'] = this.XAG;
    data['XAU'] = this.XAU;
    data['XCD'] = this.XCD;
    data['XDR'] = this.XDR;
    data['XOF'] = this.XOF;
    data['XPD'] = this.XPD;
    data['XPF'] = this.XPF;
    data['XPT'] = this.XPT;
    data['YER'] = this.YER;
    data['ZAR'] = this.ZAR;
    data['ZMW'] = this.ZMW;
    data['ZWL'] = this.ZWL;
    return data;
  }
}
