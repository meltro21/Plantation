import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/models/dailyWork.dart';
import 'package:http/http.dart' as http;

//get Daily Work
List<DailyWorkModel> parseDailyWork(String responseBody) {
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('end patseBatch get');
  return parsed
      .map<DailyWorkModel>((json) => DailyWorkModel.fromJson(json))
      .toList();
}

Future<List<DailyWorkModel>> getDailyWork(
    http.Client client, String dailyWorkId) async {
  print('start FilterDailyWork get');
  var queryParameters = {'firestoreId': '$dailyWorkId'};
  var uri = Uri.https(
      'hughplantation.herokuapp.com', '/filterDailyWork', queryParameters);
  print('Filter Variety uri is: $uri');
  final response = await http.get(uri);
  if (response.statusCode == 200) {}

  print(response);
  print('end filterVariety get');
  return compute(parseDailyWork, response.body);
}

//post daily work
Future<String> postDailyWork(
    String lightsCondition,
    oFansCondition,
    heatersCondition,
    eFansCondition,
    dehumidifierCondition,
    acCondition,
    tHigh,
    tLow,
    hHigh,
    hLow,
    feed,
    flush,
    gPlant,
    administrationPlant,
    fBuggySpray,
    fRinse,
    fFoodSpray,
    aSpray,
    bugs,
    waterORSoilTreatment,
    transplanting,
    topping,
    pruning,
    staking,
    cloning,
    harvest,
    cleaning,
    maintenance,
    construction,
    notes,
    uid,
    room) async {
  print('Fedd empty is: $feed');
  print(lightsCondition);
  double sum = 0.0;
  if (lightsCondition == '') {
    lightsCondition = "N/A";
  }
  if (oFansCondition == '') {
    oFansCondition = "N/A";
  }
  if (heatersCondition == '') {
    heatersCondition = "N/A";
  }
  if (eFansCondition == '') {
    eFansCondition = "N/A";
  }
  if (dehumidifierCondition == '') {
    dehumidifierCondition = "N/A";
  }
  if (acCondition == '') {
    acCondition = "N/A";
  }
  if (tHigh == '') {
    tHigh = "N/A";
  }
  if (tLow == '') {
    tLow = "N/A";
  }
  if (hHigh == '') {
    hHigh = "N/A";
  }
  if (hLow == '') {
    hLow = "N/A";
  }
  if (feed == '') {
    feed = "N/A";
  } else {
    sum = sum + double.parse(feed.toString());
    print("Fed sum is $sum");
  }
  if (flush == '') {
    flush = "N/A";
  } else {
    sum = sum + double.parse(flush.toString());
  }
  if (gPlant == '') {
    gPlant = "N/A";
  } else {
    sum = sum + double.parse(gPlant.toString());
  }
  if (administrationPlant == '') {
    administrationPlant = "N/A";
  } else {
    sum = sum + double.parse(administrationPlant.toString());
  }
  if (fBuggySpray == '') {
    fBuggySpray = "N/A";
  } else {
    sum = sum + double.parse(fBuggySpray.toString());
  }
  if (fRinse == '') {
    fRinse = "N/A";
  } else {
    sum = sum + double.parse(fRinse.toString());
  }
  if (fFoodSpray == '') {
    fFoodSpray = "N/A";
  } else {
    sum = sum + double.parse(fFoodSpray.toString());
  }
  if (aSpray == '') {
    aSpray = "N/A";
  } else {
    sum = sum + double.parse(aSpray.toString());
  }
  if (bugs == '') {
    bugs = "N/A";
  } else {
    sum = sum + double.parse(bugs.toString());
  }
  if (waterORSoilTreatment == '') {
    waterORSoilTreatment = "N/A";
  } else {
    sum = sum + double.parse(waterORSoilTreatment.toString());
  }
  if (transplanting == '') {
    transplanting = "N/A";
  } else {
    sum = sum + double.parse(transplanting.toString());
  }

  if (topping == '') {
    topping = "N/A";
  } else {
    sum = sum + double.parse(topping.toString());
  }
  if (pruning == '') {
    pruning = "N/A";
  } else {
    sum = sum + double.parse(pruning.toString());
  }
  if (staking == '') {
    staking = "N/A";
  } else {
    sum = sum + double.parse(staking.toString());
  }
  if (cloning == '') {
    cloning = "N/A";
  } else {
    sum = sum + double.parse(cloning.toString());
  }
  if (harvest == '') {
    harvest = "N/A";
  } else {
    sum = sum + double.parse(harvest.toString());
  }

  if (cleaning == '') {
    cleaning = "N/A";
  } else {
    sum = sum + double.parse(cleaning.toString());
  }
  if (maintenance == '') {
    maintenance = "N/A";
  } else {
    sum = sum + double.parse(maintenance.toString());
  }
  if (construction == '') {
    construction = "N/A";
  } else {
    sum = sum + double.parse(construction.toString());
  }
  if (notes == '') {
    notes = "N/A";
  }
  if (room == '') {
    room = "N/A";
  }
  print("Sum is $sum");

  final response = await http.post(
      Uri.parse('https://hughplantation.herokuapp.com/dailyWork'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "LightsCondition": lightsCondition,
        "OFansCondition": oFansCondition,
        "HeatersCondition": heatersCondition,
        "EFansCondition": eFansCondition,
        "DehumidifierCondition": dehumidifierCondition,
        "AcCondition": acCondition,
        "THigh": tHigh,
        "TLow": tLow,
        "HHigh": hHigh,
        "HLow": hLow,
        "Feed": feed,
        "Flush": flush,
        "GPlant": gPlant,
        "AdministrationPlant": administrationPlant,
        "FBuggySpray": fBuggySpray,
        "FRinse": fRinse,
        "FFoodSpray": fFoodSpray,
        "ASpray": aSpray,
        "Bugs": bugs,
        "WaterORSoilTreatment": waterORSoilTreatment,
        "Transplanting": transplanting,
        "Topping": topping,
        "Pruning": pruning,
        "Staking": staking,
        "Cloning": cloning,
        "Harvest": harvest,
        "Cleaning": cleaning,
        "Maintenance": maintenance,
        "Construction": construction,
        "Notes": notes,
        "TotalHours": sum.toString(),
        "CreatedBy": uid,
        "Room": room
      }));

  if (response.statusCode == 200) {
    print(response.statusCode);
    print('Daily Work added successfully');
    return "success";
  } else {
    print('error adding batch');
    return "error";
  }
}

//delete daily wotk
Future<int> deleteDailyWork(http.Client client, String dailyWorkId) async {
  var queryParameters = {'DailyWorkId': dailyWorkId};
  var uri = Uri.https(
      'hughplantation.herokuapp.com', '/deleteDailyWork', queryParameters);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return 1;
  } else {
    return 0;
  }
}

class PDailyWork with ChangeNotifier {
  List<DailyWorkModel> lDailyWork;
  bool loading = true;
  String dailyWorkUid;

  wrapperGetDailyWork(context, String dailyWorkId) async {
    loading = true;
    notifyListeners();
    lDailyWork = await getDailyWork(http.Client(), dailyWorkId);
    loading = false;
    notifyListeners();
  }

  wrapperDeleteDailyWork(client, String dailyWorkId) async {
    await deleteDailyWork(client, dailyWorkId);
    lDailyWork = await getDailyWork(http.Client(), dailyWorkId);
    notifyListeners();
  }

  wrapperPostDailyWork(
      context,
      String dailyWorkId,
      lightsCondition,
      oFansCondition,
      heatersCondition,
      eFansCondition,
      dehumidifierCondition,
      acCondition,
      tHigh,
      tLow,
      hHigh,
      hLow,
      feed,
      flush,
      gPlant,
      administrationPlant,
      fBuggySpray,
      fRinse,
      fFoodSpray,
      aSpray,
      bugs,
      waterORSoilTreatment,
      transplanting,
      topping,
      pruning,
      staking,
      cloning,
      harvest,
      cleaning,
      maintenance,
      construction,
      notes,
      uid,
      room) async {
    await postDailyWork(
        lightsCondition,
        oFansCondition,
        heatersCondition,
        eFansCondition,
        dehumidifierCondition,
        acCondition,
        tHigh,
        tLow,
        hHigh,
        hLow,
        feed,
        flush,
        gPlant,
        administrationPlant,
        fBuggySpray,
        fRinse,
        fFoodSpray,
        aSpray,
        bugs,
        waterORSoilTreatment,
        transplanting,
        topping,
        pruning,
        staking,
        cloning,
        harvest,
        cleaning,
        maintenance,
        construction,
        notes,
        uid,
        room);
    lDailyWork = await getDailyWork(http.Client(), dailyWorkId);
    notifyListeners();
  }
}
