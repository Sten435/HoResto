import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hogent_resto/constants/font.dart';
import 'package:hogent_resto/library.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "ABOUT",
                  style: KTitlePageStyle,
                ),
                SizedBox(height: 15),
                Column(
                  children: [
                    ItemCard(
                      widget1: Text(
                        "Stan Persoons",
                        textAlign: TextAlign.center,
                        style: KMenuDefaultStyle.copyWith(color: Colors.black),
                      ),
                      widget2: Text(
                        "Juli / 2022",
                        textAlign: TextAlign.center,
                        style: KMenuDefaultStyle.copyWith(color: Colors.white),
                      ),
                    ),
                    ItemCard(
                      widget1: Text(
                        "Flutter + NodeJs",
                        textAlign: TextAlign.center,
                        style: KMenuDefaultStyle.copyWith(color: Colors.black),
                      ),
                      widget2: Text(
                        "Raadpleeg menu’s van verschillende Hogent resto’s.",
                        textAlign: TextAlign.center,
                        style: KMenuDefaultStyle.copyWith(color: Colors.white),
                      ),
                    ),
                    ItemCard(
                      widget1: Text(
                        "Contact",
                        textAlign: TextAlign.center,
                        style: KMenuDefaultStyle.copyWith(color: Colors.black),
                      ),
                      widget2: Text(
                        "Stan.persoons2@gmail.com",
                        textAlign: TextAlign.center,
                        style: KMenuDefaultStyle.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  await launchUrl(
                    Uri(
                      scheme: "https",
                      host: "github.com",
                      path: "/Sten435",
                    ),
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: FaIcon(FontAwesomeIcons.github),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async => await launchUrl(
                  Uri(
                    scheme: "https",
                    host: "linkedin.com",
                    path: "/in/stan-persoons",
                  ),
                  mode: LaunchMode.externalApplication,
                ),
                child: FaIcon(FontAwesomeIcons.linkedin),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
