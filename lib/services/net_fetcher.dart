import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkFetcher {
  Future<dynamic> fetchJSONData(String link) async {
    http.Response response = await http.get(Uri.parse(link));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('status code:: ${response.statusCode}');
    }
  }
}
