import 'package:equatable/equatable.dart';

class Quote extends Equatable{
  final String quote;
  final String author;
  final String category;

  Quote({required this.quote, required this.author, required this.category});

  @override
  // TODO: implement props
  List<Object?> get props => [quote, author, category];
}