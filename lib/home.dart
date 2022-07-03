import 'package:flutter/material.dart';
import 'package:hogent_resto/api-handler.dart';
import 'package:hogent_resto/library.dart';
import 'package:loader_overlay/loader_overlay.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String campus = "MELLE";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.pushNamed(context, 'menu'),
          child: Icon(
            Icons.menu,
            size: 35,
          ),
        ),
        title: InkWell(
          onTap: () async {
            var netGekozenCampus = await Navigator.pushNamed(
              context,
              'resto_lijst',
              arguments: {"campus": campus},
            );
            if (netGekozenCampus != null && netGekozenCampus.toString() != campus) {
              setState(() {
                campus = netGekozenCampus.toString();
              });
            } else {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(
                    "Netwerkfout",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black,
                    ),
                  ),
                  content: Text("Server is overbelast.\nProbeer later opnieuw."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Sluit"),
                    ),
                  ],
                ),
                barrierDismissible: false,
              );
            }
          },
          child: Text(
            EersteLetterCapital(campus),
          ),
        ),
      ),
      body: LoaderOverlay(
        child: Column(
          children: [
            FutureBuilder<dynamic>(
              future: Api.getCampusData("menu/$campus"),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  print(Api.getCampusData("menu/$campus").then((value) => print(value)));
                  context.loaderOverlay.hide();
                  return Text("data");
                }
                context.loaderOverlay.show();
                return Text("");
              }),
            )
          ],
        ),
      ),
    );
  }
}
