import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:tut_app/app/constans.dart';
import 'package:tut_app/data/response/responses.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseurl)
abstract class AppServicesClient {
  factory AppServicesClient(Dio dio, {String baseUrl}) = _AppServicesClient;

  @POST('/customers/login')
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );

  @POST("/customers/ForgotPassword")
  Future<ForgotPasswordResponse> forgotPassword(@Field("email") String email);

  @POST('/customers/Signup')
  Future<AuthenticationResponse> signup(
    @Field("user_name") String userName,
    @Field("country_code") String countryCode,
    @Field("mobile_number") String mobileNumber,
    @Field("email") String email,
    @Field("password") String password,
    @Field("profile_picture") String profilePicture,
  );
}
