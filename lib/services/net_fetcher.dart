import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkFetcher {
  final String link;

  NetworkFetcher({required this.link});

  Future<dynamic> fetchJSONData() async {
    http.Response cats = await http.get(Uri.parse(link));

    if (cats.statusCode == 200)
      return jsonDecode(cats.body);
    else
      print('status code:: ${cats.statusCode}');
  }
}
