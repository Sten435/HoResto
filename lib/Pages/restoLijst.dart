import 'package:flutter/material.dart';
import 'package:hogent_resto/components/library.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:localstorage/localstorage.dart';

class RestoLijst extends StatefulWidget {
  const RestoLijst({Key? key}) : super(key: key);

  @override
  State<RestoLijst> createState() => RestoLijstState();
}

class RestoLijstState extends State<RestoLijst> {
  Widget build(BuildContext context) {
    LocalStorage localStorage = LocalStorage('hogent');
    List<dynamic> campusArray = localStorage.getItem('resto_lijst');
    var arg = ModalRoute.of(context)!.settings.arguments as Map;
    return SafeArea(
      child: Scaffold(
        body: LoaderOverlay(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Header(context, setState, clickable: false),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                color: Color.fromARGB(61, 158, 158, 158),
                thickness: 2,
                height: 0,
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Color.fromARGB(75, 182, 182, 182),
                    height: .8,
                    thickness: 2,
                    indent: 12,
                    endIndent: 12,
                  ),
                  itemBuilder: (context, i) => GestureDetector(
                    onTap: () => Navigator.pop(context, campusArray[i].toString()),
                    child: RestoRow(campusArray[i].toString(), arg['campus']),
                  ),
                  itemCount: campusArray.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget RestoRow(String campus, String selectedCampus) {
  bool currentCampus = selectedCampus.toLowerCase() == campus.toLowerCase();
  return Padding(
    padding: const EdgeInsets.all(14),
    child: Container(
      child: Text(
        EersteLetterCapital(campus),
        style: TextStyle(
          color: currentCampus ? Color.fromARGB(219, 0, 0, 0) : Colors.black,
          decoration: currentCampus ? TextDecoration.underline : TextDecoration.none,
          shadows: [
            Shadow(
              color: Color.fromARGB(73, 135, 135, 135),
              blurRadius: 4,
            ),
          ],
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}
