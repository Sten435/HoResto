import 'package:flutter/material.dart';
import 'package:hogent_resto/home.dart';
import 'package:hogent_resto/menu.dart';
import 'package:hogent_resto/resto_lijst.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hogent resto\'s',
      theme: ThemeData(
        fontFamily: 'hogent',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black87,
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
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
