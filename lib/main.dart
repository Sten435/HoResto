import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hogent_resto/Api/api-handler.dart';
import 'package:hogent_resto/Pages/home.dart';
import 'package:hogent_resto/Pages/menu.dart';
import 'package:hogent_resto/Pages/restoLijst.dart';
import 'package:localstorage/localstorage.dart';

void main() async {
  await getDataFromDatabase();
  print(await Api.getRefreshDate());
  return runApp(Main());
}

Future<void> getDataFromDatabase() async {
  final localstorage = LocalStorage('hogent');
  await localstorage.clear();

  List<String> endpoints = await Api.endpoints('menu/endpoints');
  await localstorage.setItem('resto_lijst', endpoints);

  List<dynamic> weekData = await Api.getWeekData('menu/weekdata');

  for (var i = 0; i < weekData.length; i++) {
    var naamCampus = weekData[i]['resto'];
    var dataCampus = weekData[i]['menu'];
    await localstorage.setItem(naamCampus.toString().toLowerCase(), dataCampus);
  }
}

// ignore: must_be_immutable
class Main extends StatelessWidget {
  bool connected = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hogent resto\'s',
      theme: ThemeData(
        fontFamily: 'hogent',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        'menu': (context) => Menu(),
        'resto_lijst': (context) => RestoLijst(),
      },
    );
  }
}
