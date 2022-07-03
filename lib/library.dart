import 'package:flutter/material.dart';

String EersteLetterCapital(String string) {
  if (string.length == 0) return string;
  return string[0].toUpperCase() + string.substring(1);
}

Widget ItemCard({@required Widget? widget1, @required Widget? widget2}) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          child: Center(child: widget1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(157, 162, 165, 168),
                blurRadius: 1,
                blurStyle: BlurStyle.solid,
              ),
            ],
            color: Color.fromARGB(236, 238, 241, 245),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: Center(child: widget2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(45, 0, 0, 0),
                blurRadius: 2,
                blurStyle: BlurStyle.solid,
                offset: Offset(0, 3.5),
              ),
            ],
            color: Colors.black,
          ),
        ),
      ],
    ),
    padding: EdgeInsets.all(16),
  );
}
