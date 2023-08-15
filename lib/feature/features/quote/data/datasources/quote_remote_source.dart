import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quote/core/constants/api_keys.dart';
import 'package:quote/core/constants/base_url.dart';
import 'package:quote/core/errors/exception.dart';
import 'package:quote/feature/features/quote/data/models/quote_model.dart';

abstract class QuoteRemoteDataSource{
  Future<QuoteModel> getQuote({required String category});
}

class QuoteRemoteDataSourceImpl extends QuoteRemoteDataSource{
  final http.Client client;

  QuoteRemoteDataSourceImpl({required this.client});
  @override
  Future<QuoteModel> getQuote({required String category}) async{
    try {
      final String url = BASE_URL + category;
      final response = await client.get(Uri.parse(url),headers: {'X-Api-Key': API_KEY});
      print(response.body[0]);
      List<QuoteModel> quotes = parseQuotes(response.body);
      if (response.statusCode == 200){
        print('inside');
        return quotes[0];
      }
    } catch (e){
      throw ServerException();
    }
    return QuoteModel(quote: '', author: '', category: '');
  }

  List<QuoteModel> parseQuotes(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<QuoteModel>((json) => QuoteModel.fromJson(json)).toList();
}
}