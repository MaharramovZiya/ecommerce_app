import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/user_entity.dart';
import '../../repositories/auth_repository.dart';

@injectable
class UpdateProfileUseCase implements UseCase<UserEntity, UpdateProfileParams> {
  final AuthRepository _authRepository;

  UpdateProfileUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(UpdateProfileParams params) async {
    return await _authRepository.updateProfile(params.user);
  }
}

class UpdateProfileParams {
  final UserEntity user;

  UpdateProfileParams({required this.user});
}
