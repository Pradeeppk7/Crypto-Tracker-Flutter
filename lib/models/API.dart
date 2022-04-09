import 'package:http/http.dart' as http;
import 'dart:convert';

class API {
  static Future<List<dynamic>> getMarkets() async {
    try {
      Uri requestPath = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=false");
      var response = await http.get(requestPath);
      var decodeResponse = jsonDecode(response.body);
      List<dynamic> markets = decodeResponse as List<dynamic>;
      return markets;
    } catch (ex) {
      return [];
    }
  }
static Future<List<dynamic>> fetchGraphData(String id, int days) async {
    try {
      Uri requestPath = Uri.parse("https://api.coingecko.com/api/v3/coins/${id}/market_chart?vs_currency=inr&days=${days}");

      var response = await http.get(requestPath);
      var decodedResponse = jsonDecode(response.body);

      List<dynamic> prices = decodedResponse["prices"];
      return prices;
    } catch(ex) {
      return [];
    }
  }

}
