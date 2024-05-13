import 'package:dartz/dartz.dart';
import 'package:tut_app/data/data_source/local_data_source.dart';
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
  LocalDataSource localDataSource;
  NetworkInfo networkInfo;
  RepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
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

//Home Data

  @override
  Future<Either<Failure, HomeObject>> getHomedata() async {
    try {
      //get response from cache
      final response = await localDataSource.getHomeData();

      return Right(response.toDomain());
    } catch (cacheError) {
      //cache is not existing or cache is not valid

      if (await networkInfo.isConnected) {
        try {
          final response = await remoteDataSource.gethomedata();
          if (response.status == ApiInternelStatus.SUCCESS) {
            localDataSource.saveHomeToCache(response);
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

  // StoreDetails Data

  @override
  Future<Either<Failure, StoreDetails>> getStoreDetails() async {
    try {
      // get data from cache
      final response = await localDataSource.getStoreDetails();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await networkInfo.isConnected) {
        try {
          final response = await remoteDataSource.getStoreDetails();
          if (response.status == ApiInternelStatus.SUCCESS) {
            localDataSource.saveStoreDetailsToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(
              code: response.status ?? ResponseCode.DEFAULT,
              msg: response.messages ?? ResponseMessage.DEFAULT,
            ));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }
}
