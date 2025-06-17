import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkResult<T> {
  final T? data;
  final String? error;

  NetworkResult.success(this.data) : error = null;
  NetworkResult.error(this.error) : data = null;

  bool get isSuccess => data != null;
  bool get isError => error != null;
}

class NetworkFetcher {
  Future<NetworkResult<Map<String, dynamic>>> fetchJSONData(String link) async {
    try {
      final response = await http.get(Uri.parse(link));

      if (response.statusCode == 200) {
        return NetworkResult.success(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      } else {
        return NetworkResult.error(
          'Failed to load data: ${response.statusCode}',
        );
      }
    } catch (e) {
      return NetworkResult.error('Network error: $e');
    }
  }
}
