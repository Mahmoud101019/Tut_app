import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);
  Future<AuthenticationResponse> signup(SignupRequest signupRequest);
  Future<HomeResponse> gethomedata();
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

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    return await appServicesClient.forgotPassword(email);
  }

  @override
  Future<AuthenticationResponse> signup(SignupRequest signupRequest) async {
    return await appServicesClient.signup(
      signupRequest.userName,
      signupRequest.countryCode,
      signupRequest.mobileNumber,
      signupRequest.email,
      signupRequest.password,
      "",
    );
  }

  @override
  Future<HomeResponse> gethomedata() async {
    return await appServicesClient.getHomeData();
  }
}
