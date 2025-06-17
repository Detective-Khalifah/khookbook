import "dart:convert";
import "package:http/http.dart" as http;
import "package:khookbook/models/network_result.dart";

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
          "Failed to load data: ${response.statusCode}",
        );
      }
    } catch (e) {
      return NetworkResult.error("Network error: $e");
    }
  }
}
