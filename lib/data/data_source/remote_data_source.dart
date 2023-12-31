import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  AppServicesClient appServicesClient;
  RemoteDataSourceImpl({required this.appServicesClient});
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await appServicesClient.login(
      loginRequest.email,
      loginRequest.password,
    );
  }
}
