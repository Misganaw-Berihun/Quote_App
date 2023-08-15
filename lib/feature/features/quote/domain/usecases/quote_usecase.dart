import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:quote/core/errors/failures.dart';
import 'package:quote/feature/features/quote/domain/repositories/quote_repository.dart';

import '../../../../../core/usecase/usecase.dart';
import '../entities/quote.dart';

class GetUsecase extends Usecase<Quote, QuoteParam>{
  final QuoteRepository repository;

  GetUsecase(this.repository);

  @override
  Future<Either<Failure, Quote>> call(params) async{
    return await repository.getQuote(category: params.category);
  }
}

class QuoteParam extends Equatable{
  final String category;

  const QuoteParam(this.category);
  @override
  List<Object?> get props => [category];
}