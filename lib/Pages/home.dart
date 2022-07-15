import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hogent_resto/Api/api-handler.dart';
import 'package:hogent_resto/Classes/globalState.dart';
import 'package:hogent_resto/components/constants.dart';
import 'package:hogent_resto/components/library.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:localstorage/localstorage.dart';
import 'package:separated_column/separated_column.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  Widget build(BuildContext context) {
    List<dynamic>? dataCampus = LocalStorage('hogent').getItem(GlobalState.campus.toLowerCase().replaceAll(' ', '-'));
    if (dataCampus == null) {
      return SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Header(context, setState),
                Column(
                  children: [
                    Icon(
                      Icons.error_rounded,
                      size: 65,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Fout bij het downloaden',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Meer info: ',
                          style: TextStyle(fontSize: 19),
                        ),
                        InkWell(
                          child: Text(
                            'Resto Campus',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 19,
                            ),
                          ),
                          onTap: () async => await launchUrlString('https://www.hogent.be/student/catering/weekmenu-${GlobalState.campus.toLowerCase().replaceAll(' ', '-')}'),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(),
              ],
            ),
          ),
        ),
      );
    }
    if (GlobalState.currentCampus != GlobalState.campus) {
      GlobalState.selectedIndex = 0;
      GlobalState.currentCampus = GlobalState.campus;
    }
//-> Toon content van Api
    List<dynamic> weekdagen = dataCampus;
    GlobalState.maxSelectedIndex = weekdagen.length - 1;

    String geselecteerdeDag = (weekdagen[GlobalState.selectedIndex] as Map)['header'];
    List dataLijst = (weekdagen[GlobalState.selectedIndex] as Map)['food'] as List;

    dataLijst.removeWhere((mapItem) {
      return (mapItem as Map).values.join() == 'null';
    });

    return SafeArea(
      child: Scaffold(
        persistentFooterButtons: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: GestureDetector(
                  child: FaIcon(FontAwesomeIcons.userLarge),
                  onTap: () => Navigator.pushNamed(context, 'menu'),
                ),
              ),
              Center(
                child: GestureDetector(
                  child: FaIcon(FontAwesomeIcons.github),
                  onTap: () async => await launchUrlString('https://github.com/Sten435/hogent_resto'),
                ),
              ),
            ],
          )
        ],
        backgroundColor: Color.fromARGB(255, 246, 246, 246),
        body: LoaderOverlay(
          child: Column(
            children: [
              Header(context, setState),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: WeekSelector(
                  geselecteerdeDag,
                  context,
                  () => setState(() {
                    if (GlobalState.selectedIndex >= GlobalState.maxSelectedIndex) return;
                    GlobalState.selectedIndex++;
                  }),
                  () => setState(() {
                    if (GlobalState.selectedIndex <= 0) return;
                    GlobalState.selectedIndex--;
                  }),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Divider(
                height: 0,
                thickness: 1,
                color: Color.fromARGB(9, 28, 28, 28),
              ),
              Container(
                width: double.infinity,
                height: 0,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(19, 81, 81, 81),
                      blurRadius: 2,
                      spreadRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),
              bodyContent(dataLijst),
            ],
          ),
        ),
      ),
    );
  }

  Widget bodyContent(List data) {
    if (data.length > 0) {
      return Expanded(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(10, 0, 0, 0),
                      spreadRadius: 2,
                      blurRadius: 5,
                      blurStyle: BlurStyle.solid,
                    )
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SeparatedColumn(
                  children: data.map((row) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                      child: ItemCard(
                        widget1: Text(
                          EersteLetterCapital((row as Map).keys.join().toString()),
                          style: KMenuDefaultStyle.copyWith(
                            color: Color.fromARGB(220, 85, 85, 85),
                            fontWeight: FontWeight.w100,
                            decoration: TextDecoration.underline,
                            decorationColor: Color.fromARGB(59, 0, 0, 0),
                            decorationThickness: 2,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        widget2: Text(
                          EersteLetterCapital((row).values.join().toString()),
                          style: KMenuDefaultStyle.copyWith(
                            color: Color.fromARGB(255, 30, 30, 30),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    );
                  }).toList(),
                  includeOuterSeparators: false,
                  separatorBuilder: (BuildContext context, int index) => Divider(
                    color: Color.fromARGB(75, 182, 182, 182),
                    height: .8,
                    thickness: 2,
                    indent: 12,
                    endIndent: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

//-> Wanneer er geen eten is op de geselecteerde dag
    return Expanded(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 18,
              ),
              child: FaIcon(
                Icons.no_food_rounded,
                color: Colors.black,
                size: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 35,
              ),
              child: Text(
                'Geen Menu Deze Dag.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
