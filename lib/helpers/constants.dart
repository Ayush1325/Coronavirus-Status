/// Most of the constants

import 'package:flutter/material.dart';

class IndianTrackerEndpoints {
  static const general = "https://api.covid19india.org/data.json";
  static const state =
      "https://api.covid19india.org/v2/state_district_wise.json";
  static const stateTested =
      "https://api.covid19india.org/state_test_data.json";
  static const updates = "https://api.covid19india.org/updatelog/log.json";
}

class IndianTrackerJsonTags {
  static const dailyConfirmed = 'dailyconfirmed';
  static const dailyRecovered = "dailyrecovered";
  static const dailyDeceased = "dailydeceased";
  static const totalConfirmed = 'totalconfirmed';
  static const totalRecovered = 'totalrecovered';
  static const totalDeceased = "totaldeceased";
  static const caseTimeSeries = 'cases_time_series';
  static const stateList = 'statewise';
  static const lastUpdate = 'lastupdatedtime';
  static const stateDistrictConfirmed = 'confirmed';
  static const stateDistrictActive = 'active';
  static const stateDistrictRecovered = 'recovered';
  static const stateDistrictDeceased = 'deaths';
  static const deltaConfirmed = 'deltaconfirmed';
  static const deltaRecovered = 'deltarecovered';
  static const deltaDeceased = 'deltadeaths';
  static const dateFormat = "dd/MM/yyyy HH:mm:ss";
  static const districtData = 'districtData';
}

class DataColors {
  static const confirmed = Colors.red;
  static const recovered = Colors.green;
  static const active = Colors.blue;
  static const deceased = Colors.blueGrey;
  static const tested = Colors.blueAccent;
}

class Titles {
  static const fullConfirmed = "Confirmed";
  static const fullRecovered = "Recovered";
  static const fullDeceased = "Deceased";
  static const fullTested = "Tested";
  static const fullActive = "Active";
  static const abbrConfirmed = "CNFD";
  static const abbrRecovered = "RCVD";
  static const abbrDeceased = "DCSD";
  static const abbrActive = "ACTV";
  static const abbrTested = "TSTD";

  static const mapper = {
    fullConfirmed: abbrConfirmed,
    fullDeceased: abbrDeceased,
    fullRecovered: abbrRecovered,
    fullActive: abbrActive,
  };
}

const updateURL =
    "https://api.github.com/repos/Ayush1325/Coronavirus-Status/releases/latest";
