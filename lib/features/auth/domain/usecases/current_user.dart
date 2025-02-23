import 'package:azan_reminder/core/common/entities/user.dart';
import 'package:azan_reminder/core/common/error/failure.dart';
import 'package:azan_reminder/core/common/usecase/usecase.dart';
import 'package:azan_reminder/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<UserEntity, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
