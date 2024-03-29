class LoginRequest {
  String email;
  String password;
  LoginRequest({
    required this.email,
    required this.password,
  });
}

class SignupRequest {
  String userName;
  String countryCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;
  SignupRequest({
    required this.userName,
    required this.countryCode,
    required this.mobileNumber,
    required this.email,
    required this.password,
    required this.profilePicture,
  });
}
