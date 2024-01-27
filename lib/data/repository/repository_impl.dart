import 'package:dartz/dartz.dart';
import 'package:tut_app/data/data_source/remote_data_source.dart';
import 'package:tut_app/data/mapper/mapper.dart';
import 'package:tut_app/data/network/error_handler.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/domain/repositroy/repository.dart';

class RepositoryImpl implements Repository {
  RemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;
  RepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  //Login
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.login(loginRequest);
        if (response.status == ApiInternelStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return left(
            Failure(
              code: ApiInternelStatus.Failure,
              msg: response.messages ?? ResponseMessage.DEFAULT,
            ),
          );
        }
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left(
        DataSource.NO_INTERNET_CONNECTION.getFailure(),
      );
    }
  }

  //ForGetPassword
  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await networkInfo.isConnected) {
      try {
        // its safe to call API
        final response = await remoteDataSource.forgotPassword(email);

        if (response.status == ApiInternelStatus.SUCCESS) {
          // success
          // return right
          return Right(response.toDomain());
        } else {
          // failure
          // return left
          return Left(Failure(
              code: response.status ?? ResponseCode.DEFAULT,
              msg: response.messages ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return network connection error
      // return left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  //SignUp
  @override
  Future<Either<Failure, Authentication>> signup(
      SignupRequest signupRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.signup(signupRequest);
        if (response.status == ApiInternelStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return left(
            Failure(
              code: ApiInternelStatus.Failure,
              msg: response.messages ?? ResponseMessage.DEFAULT,
            ),
          );
        }
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left(
        DataSource.NO_INTERNET_CONNECTION.getFailure(),
      );
    }
  }
}
