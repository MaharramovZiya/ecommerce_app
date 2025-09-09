import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/user_entity.dart';
import '../../repositories/auth_repository.dart';

@injectable
class GetCurrentUserUseCase implements UseCase<UserEntity?, NoParams> {
  final AuthRepository _authRepository;

  GetCurrentUserUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) async {
    return await _authRepository.getCurrentUser();
  }
}
