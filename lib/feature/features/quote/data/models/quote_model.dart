import 'package:quote/feature/features/quote/domain/entities/quote.dart';

class QuoteModel extends Quote{
  QuoteModel({required super.quote, required super.author, required super.category});

   factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
    quote: json['quote'],
    author: json['author'],
    category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quote': quote,
      'author': author,
      'category': category
    };
  }
}