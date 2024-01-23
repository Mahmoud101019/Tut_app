import 'package:dartz/dartz.dart';
import 'package:tut_app/domain/repositroy/repository.dart';

import '../../data/network/failure.dart';
import 'base_usecase.dart';

class ForgotPasswordUseCase implements BaseUseCase<String, String> {
  final Repository repository;

  ForgotPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, String>> execute(String input) async {
    return await repository.forgotPassword(input);
  }
}
