import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quote_of_the_day/quote_model.dart';

class Api_service {
  quote_model quote = quote_model();
  Future<quote_model> getQuote() async {
    final response =
        await http.get(Uri.parse('https://zenquotes.io/api/today'));
    var data = await jsonDecode(
      response.body.toString(),
    );
    print('data');
    if (response.statusCode == 200) {
      quote.quote = data[0]['q'];
      quote.author = data[0]['a'];

      return quote;
    }
    return quote;
  }
}
