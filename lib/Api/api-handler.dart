import 'dart:convert';
import 'package:hogent_resto/components/library.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  static Future<List<String>> endpoints(String endpoint) async {
    List<String> endpoints = [];
    bool hasFailed = false;
    do {
      try {
        if (hasFailed) await Future.delayed(Duration(seconds: 5));
        await dotenv.load(fileName: '.env');
        var uri = Uri.http(dotenv.env['baseUri'].toString(), endpoint.toLowerCase().replaceAll(' ', '-'));

        var response = await http.get(uri);
        var jsonResponse = json.decode(response.body.toString());

        for (var element in jsonResponse['end-points']) {
          String campus = element['naam'].toString();

          if (campus.contains('-')) {
            campus = EersteLetterCapital(campus.split('-')[0]) + ' ' + EersteLetterCapital(campus.split('-')[1]);
          }

          endpoints.add(EersteLetterCapital(campus));
        }
        hasFailed = false;
      } catch (e) {
        hasFailed = true;
        print('error<api-handler -> endpoints>: ik probeer opniew\n\n$e');
      }
    } while (hasFailed);
    return endpoints;
  }

  // static Future<dynamic> getCampusData(String campus) async {
  //   List<dynamic> weekdagen = [];
  //   bool hasFailed = false;
  //   do {
  //     try {
  //       if (hasFailed) await Future.delayed(Duration(seconds: 5));
  //       await dotenv.load(fileName: '.env');
  //       var uri = Uri.http(dotenv.env['baseUri'].toString(), campus.toLowerCase().replaceAll(' ', '-'));

  //       var response = await http.get(uri);
  //       var jsonResponse = json.decode(response.body.toString());
  //       List<dynamic> menuData = jsonResponse['menu'];

  //       for (int i = 0; i < menuData.length; i++) {
  //         Map<String, dynamic> data = menuData[i];
  //         weekdagen.add(data);
  //       }

  //       hasFailed = false;
  //     } catch (e) {
  //       hasFailed = true;
  //       print('error<api-handler -> getCampusData>: ik probeer opnieuw\n\n$e');
  //     }
  //   } while (hasFailed);
  //   return weekdagen;
  // }

  static Future<dynamic> getWeekData(String endpoint) async {
    bool hasFailed = false;
    var data;
    do {
      try {
        if (hasFailed) await Future.delayed(Duration(seconds: 5));
        await dotenv.load(fileName: '.env');
        var uri = Uri.http(dotenv.env['baseUri'].toString(), endpoint);

        var response = await http.get(uri);
        List<dynamic> jsonResponse = json.decode(response.body.toString());
        List<dynamic> campusArray = jsonResponse.map((campus) => campus['data']).toList();
        data = json.decode(campusArray.toString());
      } catch (e) {
        hasFailed = true;
        print('error<api-handler -> getWeekData>: ik probeer opnieuw\n\n$e');
      }
    } while (hasFailed);
    return data;
  }

  static Future<String?> getRefreshDate() async {
    bool hasFailed = false;
    var data;
    do {
      try {
        if (hasFailed) await Future.delayed(Duration(seconds: 5));
        await dotenv.load(fileName: '.env');
        var uri = Uri.http(dotenv.env['baseUri'].toString(), '/menu/refresh');

        var response = await http.get(uri);
        dynamic jsonResponse = json.decode(response.body.toString());

        if (jsonResponse['error'].toString() == 'false') {
          return jsonResponse['timestamp'];
        } else
          return 'None';
      } catch (e) {
        hasFailed = true;
        print('error<api-handler -> getRefreshDate>: ik probeer opnieuw\n\n$e');
      }
    } while (hasFailed);
  }
}
