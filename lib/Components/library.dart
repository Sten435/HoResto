import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hogent_resto/Classes/globalState.dart';
import 'package:hogent_resto/components/constants.dart';

String EersteLetterCapital(String string) {
  if (string.length == 0) return string;
  return string[0].toUpperCase() + string.substring(1);
}

Widget ItemCard({@required Widget? widget1, @required Widget? widget2}) {
  return Container(
    alignment: Alignment.centerLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(4),
          child: widget1,
        ),
        Container(
          padding: EdgeInsets.all(4),
          child: widget2,
        ),
      ],
    ),
  );
}

Widget WeekSelector(String dagVanDeWeek, BuildContext context, Function plusState, Function minState) {
  const arrayButtonColor = Color.fromARGB(255, 179, 179, 179);
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      GestureDetector(
        child: Container(
          width: 30,
          height: 30,
          color: Colors.transparent,
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.chevronLeft,
              color: GlobalState.selectedIndex > 0 ? arrayButtonColor : Color.fromARGB(77, 192, 192, 192),
              size: 20,
            ),
          ),
        ),
        onTap: () {
          minState();
        },
      ),
      Container(
        width: 110,
        child: Center(
          child: Text(
            dagVanDeWeek,
            style: kWeekDay,
          ),
        ),
      ),
      GestureDetector(
        child: Container(
          width: 30,
          height: 30,
          color: Colors.transparent,
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: GlobalState.selectedIndex < GlobalState.maxSelectedIndex ? arrayButtonColor : Color.fromARGB(77, 192, 192, 192),
              size: 20,
            ),
          ),
        ),
        onTap: () {
          plusState();
        },
      ),
    ],
  );
}

Widget Header(BuildContext context, Function setState, {bool clickable = true}) {
  String headerTitel = '';

  if (EersteLetterCapital(GlobalState.campus).contains('-')) {
    headerTitel = EersteLetterCapital(GlobalState.campus).split('-')[0] + ' ' + EersteLetterCapital(EersteLetterCapital(GlobalState.campus).split('-')[1]);
  } else {
    headerTitel = EersteLetterCapital(GlobalState.campus);
  }
  return GestureDetector(
    onTap: () async {
      if (!clickable) return;
      var netGekozenCampus = await Navigator.pushNamed(
        context,
        'resto_lijst',
        arguments: {'campus': GlobalState.campus},
      );

      if (netGekozenCampus != null) {
        if (netGekozenCampus.toString().toLowerCase() != GlobalState.campus.toLowerCase()) {
          setState(() => GlobalState.campus = netGekozenCampus.toString());
        }
      }
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 25,
        ),
        Text(
          headerTitel,
          // textAlign: widget.align,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 28.0,
          ),
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}
