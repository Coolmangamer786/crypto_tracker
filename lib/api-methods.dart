import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

class CoinApi {
  static Future<List<Coin>> getCurrentData(BuildContext context) async {
    final url = 'https://api.coingecko.com/api/v3/coins/';
    // final url = 'https://api.covid19india.org/v4/min/data.min.json';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    return body.map<Coin>(Coin.fromJson).toList();
  }
}
