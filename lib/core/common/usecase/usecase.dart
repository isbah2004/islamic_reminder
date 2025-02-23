import 'package:azan_reminder/core/constants/exports.dart';
import 'package:fpdart/fpdart.dart';
abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}