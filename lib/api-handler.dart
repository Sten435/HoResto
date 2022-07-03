import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  static Future<List<String>> Endpoints(String endpoint) async {
    List<String> endpoints = [];
    bool hasFailed = true;
    do {
      if (hasFailed) await Future.delayed(Duration(seconds: 5));
      try {
        await dotenv.load(fileName: ".env");
        var uri = Uri.http(dotenv.env['baseUri'].toString(), endpoint);

        var response = await http.get(uri);
        var jsonResponse = json.decode(response.body.toString());
        for (var element in jsonResponse["end-points"]) {
          endpoints.add(element["naam"]);
        }
        hasFailed = false;
      } catch (e, stacktrace) {
        hasFailed = true;
        print('error<api-handler -> Endpoints>: $e\n\n$stacktrace');
      }
    } while (hasFailed);
    return endpoints;
  }

  static Future<List<Map<dynamic, dynamic>?>> getCampusData(String campus) async {
    List<Map<dynamic, dynamic>?> weekdagen = [];
    bool hasFailed = true;
    do {
      if (hasFailed) Future.delayed(Duration(seconds: 5));
      try {
        await dotenv.load(fileName: ".env");
        var uri = Uri.http(dotenv.env['baseUri'].toString(), campus);

        var response = await http.get(uri);
        var jsonResponse = json.decode(response.body.toString());

        for (int i = 0; i < jsonResponse["menu"]["food"]; i++) {
          weekdagen.add(jsonResponse["menu"]["food"][i]);
        }
        hasFailed = false;
      } catch (e, stacktrace) {
        hasFailed = true;
        print('error<api-handler -> getCampusData>: $e\n\n$stacktrace');
      }
    } while (hasFailed);
    return weekdagen;
  }
}
