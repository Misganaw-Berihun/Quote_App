part of 'quote_bloc.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();  

  @override
  List<Object> get props => [];
}
class QuoteInitial extends QuoteState {}

class QuoteLoadingState extends QuoteState {
}

class GetQuoteSuccess extends QuoteState {
  final Quote quote;

  const GetQuoteSuccess(this.quote);



  @override
  List<Object> get props => [quote];
}

class GetQuoteFailed extends QuoteState{ 
  final String message;

  const GetQuoteFailed(this.message);

  @override
  List<Object> get props => [message];
}