import 'package:flutter/material.dart';
import 'package:hogent_resto/api-handler.dart';
import 'package:hogent_resto/library.dart';

class RestoLijst extends StatefulWidget {
  const RestoLijst({Key? key}) : super(key: key);

  @override
  State<RestoLijst> createState() => RestoLijstState();
}

class RestoLijstState extends State<RestoLijst> {
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          FutureBuilder<dynamic>(
            future: Api.Endpoints("menu/endpoints"),
            builder: (context, snapshot) {
              var rows = snapshot.data as List?;
              if (snapshot.hasData) {
                if (rows?.length == 0) {
                  Navigator.pop(context, null);
                }
                return Expanded(
                  child: ListView(
                    children: rows!
                        .map(
                          (e) => GestureDetector(
                            onTap: () => Navigator.pop(context, e.toString()),
                            child: RestoRow(e.toString(), arg["campus"]),
                          ),
                        )
                        .toList(),
                  ),
                );
              }
              return Text("Loading");
            },
          ),
        ],
      ),
    );
  }
}

Widget RestoRow(String campus, String selectedCampus) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Container(
      height: 45,
      decoration: BoxDecoration(
        color: Color.fromARGB(224, 0, 0, 0),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Color.fromARGB(209, 158, 158, 158),
            blurStyle: BlurStyle.solid,
            offset: Offset(0, 2),
          ),
          BoxShadow(
            blurRadius: 1,
            color: Color.fromARGB(70, 184, 184, 184),
            blurStyle: BlurStyle.solid,
            offset: Offset(0, -2),
          )
        ],
      ),
      child: Center(
        child: Text(
          EersteLetterCapital(campus),
          style: TextStyle(
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black,
                blurRadius: 1,
              ),
            ],
            decoration: selectedCampus.toLowerCase() == campus.toLowerCase()
                ? TextDecoration.underline
                : TextDecoration.none,
            decorationThickness: 1.2,
            decorationColor: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    ),
  );
}
