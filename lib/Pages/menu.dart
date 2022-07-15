import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hogent_resto/components/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 30),
            Text(
              'ABOUT',
              style: KTitlePageStyle,
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.asset(
                          'ikke.jpeg',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Stan Persoons',
                      style: TextStyle(fontSize: 22),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Stan.persoons2@gmail.com',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.black12,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      await launchUrl(
                        Uri(
                          scheme: 'https',
                          host: 'github.com',
                          path: '/Sten435',
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
                        scheme: 'https',
                        host: 'linkedin.com',
                        path: '/in/stan-persoons',
                      ),
                      mode: LaunchMode.externalApplication,
                    ),
                    child: FaIcon(FontAwesomeIcons.linkedin),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async => await launchUrl(
                      Uri(
                        scheme: 'https',
                        host: 'twitter.com',
                        path: '/persoons_stan',
                      ),
                      mode: LaunchMode.externalApplication,
                    ),
                    child: FaIcon(FontAwesomeIcons.twitter),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async => await launchUrl(
                      Uri(
                        scheme: 'https',
                        host: 'discord.com',
                        path: '/users/266144138657792002',
                      ),
                      mode: LaunchMode.externalApplication,
                    ),
                    child: FaIcon(FontAwesomeIcons.discord),
                  ),
                )
              ],
            ),
            Divider(
              color: Colors.black12,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              height: 10,
            ),
            Text('Deze app is niet ontwikkeld door Hogent.'),
            Text('Daarom kan de data onjuist zijn.'),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 65,
            child: Center(
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 33, 33, 33),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Ga Terug',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
