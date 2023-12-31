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
}
