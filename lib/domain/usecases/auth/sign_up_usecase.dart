import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/user_entity.dart';
import '../../repositories/auth_repository.dart';

@injectable
class SignUpUseCase implements UseCase<UserEntity, SignUpParams> {
  final AuthRepository _authRepository;

  SignUpUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) async {
    return await _authRepository.signUpWithEmailAndPassword(
      params.email,
      params.password,
      params.name,
    );
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String name;

  SignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
