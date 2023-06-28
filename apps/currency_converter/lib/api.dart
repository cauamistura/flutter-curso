import 'dart:convert';

import 'package:http/http.dart' as http;

const String REQUEST =
    'https://economia.awesomeapi.com.br/last/USD-BRL,EUR-BRL';

class API {
  static Future<Map> getData() async {
    http.Response response = await http.get(Uri.parse(REQUEST));
    await Future.delayed(const Duration(seconds: 1));
    return json.decode(response.body);
  }
}
