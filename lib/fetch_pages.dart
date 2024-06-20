library fetch_pages;

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchPages {
  static final logger = Logger();
  static var responseData;
  static Future<void> fetchPagesFromAPI(String url) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      if (pref.getString("responseBodyFromAPI") != null) {
        responseData = json.decode(pref.getString("responseBodyFromAPI")!);
      }
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        responseData = json.decode(response.body);
        pref.setString("responseBodyFromAPI", response.body);
        logger.i("Fetched pages from API successfully!");
      } else if (pref.getString('responseBody') != null) {
        responseData = pref.getString('responseBody');
        logger
            .w("Error fetching pages from API, loaded from sharedPreferences");
      } else {
        logger.e("Error fetching page data from API ${response.body}");
      }
    } catch (e) {
      logger.e("Exception while fetching pages from API $e");
    }
  }

  static Future<String?> getPageByName(String name) async {
    if (responseData[name] != null) {
      logger.i("Fetched $name successfully!");
      return json.encode(responseData[name]);
    }
    logger.e("Could not load the page requested: $name");
    return null;
  }
}
