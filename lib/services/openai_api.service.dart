import 'dart:convert';

import '../utils/constant.dart';
import 'package:http/http.dart' as http;

Future<String> getResponse(String prompt) async {
  var url = Uri.https("api.openai.com", "/v1/completions");
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $apiSecretKey"
      },
      body: json.encode({
        "model": "text-davinci-003",
        "prompt": prompt,
        'temperature': 0,
        'max_tokens': 2000,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      return data['choices'][0]['text'];
    } else {
      throw Exception("${response.statusCode}");
    }
  } catch (e) {
    rethrow;
  }
}
