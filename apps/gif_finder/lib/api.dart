import 'dart:convert';

import 'package:http/http.dart' as http;

mixin Api {
  static Future<Map> getGifs(int offset, String? search) async {
    http.Response response;
    if (search == null) {
      response = await http.get(Uri.parse(
          "https://api.giphy.com/v1/gifs/trending?api_key=PasZCL10syHL2OmDLvAsZ9TvTFdgq9Jp&limit=20&offset=$offset&rating=g&bundle=messaging_non_clips"));
    } else {
      response = await http.get(Uri.parse(
          "https://api.giphy.com/v1/gifs/search?api_key=PasZCL10syHL2OmDLvAsZ9TvTFdgq9Jp&q=$search&limit=20&offset=$offset&rating=g&lang=en&bundle=messaging_non_clips"));
    }

    return json.decode(response.body);
  }
}
