import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/auth_repository.dart';

@injectable
class SignOutUseCase implements UseCase<void, NoParams> {
  final AuthRepository _authRepository;

  SignOutUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _authRepository.signOut();
  }
}
