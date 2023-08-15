import 'package:dartz/dartz.dart';
import 'package:quote/core/errors/exception.dart';
import 'package:quote/core/errors/failures.dart';
import 'package:quote/feature/features/quote/data/datasources/quote_remote_source.dart';
import 'package:quote/feature/features/quote/domain/entities/quote.dart';
import 'package:quote/feature/features/quote/domain/repositories/quote_repository.dart';

class QuoteRepositoryImpl extends QuoteRepository{
  // final NetworkInfo networkInfo;
  final QuoteRemoteDataSource quoteRemoteDataSource;

  QuoteRepositoryImpl(this.quoteRemoteDataSource);

  @override
  Future<Either<Failure, Quote>> getQuote({required String category}) async{
    try {
      final response = await quoteRemoteDataSource.getQuote(category: category);
      return Right(response);
    } on ServerException{
      return Left(ServerFailure());
    } on NetworkConnectionException {
      return Left(NetworkFailure());
    }
  }


}