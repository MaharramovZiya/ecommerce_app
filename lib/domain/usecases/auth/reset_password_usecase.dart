import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/auth_repository.dart';

@injectable
class ResetPasswordUseCase implements UseCase<void, ResetPasswordParams> {
  final AuthRepository _authRepository;

  ResetPasswordUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(ResetPasswordParams params) async {
    return await _authRepository.resetPassword(params.email);
  }
}

class ResetPasswordParams {
  final String email;

  ResetPasswordParams({required this.email});
}
