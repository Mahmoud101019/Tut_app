import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/domain/repositroy/repository.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

class HomeUseCase implements BaseUseCase<void, HomeObject> {
  final Repository repository;
  HomeUseCase({
    required this.repository,
  });
  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await repository.getHomedata();
  }
}
