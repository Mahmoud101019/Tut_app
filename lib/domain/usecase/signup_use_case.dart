import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/domain/repositroy/repository.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

class SignUpUseCase implements BaseUseCase<SignUpUseCaseInPut, Authentication> {
  final Repository repository;
  SignUpUseCase({
    required this.repository,
  });
  @override
  Future<Either<Failure, Authentication>> execute(
      SignUpUseCaseInPut input) async {
    return await repository.signup(SignupRequest(
      userName: input.userName,
      countryCode: input.countryCode,
      mobileNumber: input.mobileNumber,
      email: input.email,
      password: input.password,
      profilePicture: input.profilePicture,
    ));
  }
}

class SignUpUseCaseInPut {
  String userName;
  String countryCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;
  SignUpUseCaseInPut({
    required this.userName,
    required this.countryCode,
    required this.mobileNumber,
    required this.email,
    required this.password,
    required this.profilePicture,
  });
}
