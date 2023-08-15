import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quote/feature/features/quote/domain/entities/quote.dart';
import 'package:quote/feature/features/quote/domain/usecases/quote_usecase.dart';

import '../../../../../core/errors/failures.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final GetUsecase usecase;
  QuoteBloc(this.usecase) : super(QuoteInitial()) {
    on<GetQuoteEvent>(_onGetQuoteEvent);
  }

  void _onGetQuoteEvent(GetQuoteEvent event, Emitter<QuoteState> emit) async{
    emit(QuoteLoadingState());
    final getQuote = await usecase(QuoteParam(event.category));
    emit(_successOrFailure(getQuote));
  }

  QuoteState _successOrFailure(Either<Failure, Quote> failureOrSuccess){
    return failureOrSuccess.fold( 
      (failure) => GetQuoteFailed(mapFailure(failure)),
      (quote) => GetQuoteSuccess(quote),);
  }

  String mapFailure(Failure failure){
    switch (failure.runtimeType){
      case ServerFailure:
        return 'Server Failure';
      case NetworkFailure:
        return 'Network Failure';
      default:
        return 'unknown Failure';
    }
  }
}
